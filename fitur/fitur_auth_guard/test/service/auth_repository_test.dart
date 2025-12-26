import 'package:auth_test_support/mock/mock_auth_api_client.dart';
import 'package:common/domain/model/user.dart';
import 'package:common_test_support/mock/mock_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  test("When login succeed, it must set the GetIt with the User "
      "and token must be set", () async {
    registerFallbackValue(PostLoginDto(password: 'y', username: 'y'));

    final mockApiClient = MockAuthApiClient();
    when(() => mockApiClient.login(any())).thenAnswer((_) async =>
        Response('{ '
            '"token" : "some_random_token_vwxyz",'
            '"user": {'
              '"id": 2,'
              '"is_admin": false,'
              '"username": "non_admin"'
            '}'
          '}', 200)
    );

    final mockTokenManager = MockTokenManager();
    when(() => mockTokenManager.setToken(any())).thenAnswer((_) async {});

    final repository = LoginRepositoryImpl(
      apiClient: mockApiClient,
      tokenManager: mockTokenManager);

    await repository.login(PostLoginDto(password: 'hm3456', username: 'non_admin'));

    final registeredUser = GetIt.I.get<User>();

    verify(() => mockTokenManager.setToken('some_random_token_vwxyz')).called(1);
    expect(registeredUser.id, 2);
    expect(registeredUser.username, 'non_admin');
    expect(registeredUser.token, 'some_random_token_vwxyz');
    expect(registeredUser.isAdmin, false);
  });
}