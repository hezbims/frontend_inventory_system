import 'dart:io';

import 'package:auth_test_support/mock/mock_auth_api_client.dart';
import 'package:common/data/repository/user_repository_impl.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/response/api_response.dart';
import 'package:common_test_support/mock/mock_token_manager.dart';
import 'package:dependencies/flutter_dotenv.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main(){
  setUp(() async => await GetIt.I.reset());
  tearDown(() async => await GetIt.I.reset());

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

  test("Get user should correctly map to User model", () async {
    dotenv.loadFromString(envString: "API_URL=http://127.0.0.1:4010/api");
    final mockTokenManager = MockTokenManager();
    when(() => mockTokenManager.getLocalStorageTokenizedHeader()).thenAnswer((_) async => {
      HttpHeaders.authorizationHeader: "Bearer xxcvxbxcbzxcb",
    });
    when(() => mockTokenManager.setToken(any())).thenAnswer((_) async {});
    GetIt.I.registerSingleton<ITokenManager>(mockTokenManager);

    final result = await UserRepositoryImpl().getUser()
      .then((res) => res as ApiResponseSuccess<User>)
      .then((res) => res.data!);
    expect(result.username, "admin");
    expect(result.token, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImFkbWluIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQWRtaW4iLCJleHAiOjE3NjgyNzE0MDEsImlzcyI6Imh0dHA6Ly9sb2NhbGhvc3Q6NTE1NCIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6MzAwMCJ9.H46pIQejekT9s-GuXsEauIqGjK2zu2vitYyWAhLRu8Y");
    expect(result.isAdmin, true);
    expect(result.id, 1);
  });
}