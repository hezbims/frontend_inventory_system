import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_auth_guard/data/api_client/login_api_client.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit.mocks.dart';

@GenerateMocks([LoginApiClient , ITokenManager])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'Ketika klik login, maka set token di token manager terpanggil',
    () async {
    final token = '81|laravel_sanctum_Q9Y4jVeoEMYLV9nfnyHl20DZHYjsHfmJElcXnlx3ba57b5a5';
    final mockApiClient = prepareMockApiClient(token: token);
    final mockTokenManager = prepareMockTokenManager();

    final loginProvider = LoginProvider(
      repository: LoginRepositoryImpl(
        apiClient:mockApiClient,
      ),
    );

    await loginProvider.login!();

    verify(mockApiClient.login(any)).called(1);

    verify(mockTokenManager.setToken(token)).called(1);

  } , tags: TestTags.fastTetst);
}

MockLoginApiClient prepareMockApiClient({required String token}){
  final mockLoginApiClient = MockLoginApiClient();

  final jsonBody = '''
      {
        "message": "Sukses",
        "token": "$token",
        "user": {
            "id": 1,
            "username": "admin",
            "is_admin": 1,
            "created_at": "2023-09-01T06:38:23.000000Z",
            "updated_at": "2023-09-01T06:38:23.000000Z"
        }
      }
    ''';

  when(mockLoginApiClient.login(any)).thenAnswer(
    (realInvocation) async{
      debugPrint("login pada mock api client dipanggil");
      return Response(jsonBody, 200);
    },
  );

  return mockLoginApiClient;
}

MockITokenManager prepareMockTokenManager(){
  final tokenManager = MockITokenManager();
  when(tokenManager.setToken(any))
      .thenAnswer((realInvocation) async {true;});

  GetIt.I.registerSingleton<ITokenManager>(tokenManager);
  return tokenManager;
}