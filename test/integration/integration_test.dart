// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'dart:io';

import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/http.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_bu_fan/main.dart';

import '../common/mock/mock_barang_repository.dart';
import '../common/mock/mock_user_repository.dart';
import '../fitur_auth_guard/fake/fake_post_login_dto.dart';
import '../fitur_auth_guard/mock/mock_login_api_client.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll((){
    registerFallbackValue(FakePostLoginDto());
  });

  testWidgets(
      'Ketika user login, maka user berhak mengakses data',
          (tester) async {
        const token = 'ini-token-rahasia ';
        final mockApiClient = prepareMockApiClient(token: token);

        final mockUserRepository = MockUserRepository();
        when(() => mockUserRepository.getUser()).thenAnswer(
          (invocation) async {
            try {
              final user = GetIt.I.get<User>();
              return ApiResponseSuccess(data: user);
            } catch (e) {
              return ApiResponseFailed(statusCode: HttpStatus.unauthorized);
            }
          }
        );
        GetIt.I.registerSingleton(
          UserProvider(repository: mockUserRepository)
        );

        final tokenManager = TokenManagerImpl();
        GetIt.I.registerSingleton<ITokenManager>(tokenManager);
        GetIt.I.registerFactory(() =>
          LoginProvider(
            repository: LoginRepositoryImpl(
              apiClient: mockApiClient,
              tokenManager: tokenManager,
            )
          )
        );

        final mockBarangRepository = MockBarangRepository();
        when(() => mockBarangRepository.getStockBarang(any(), any()))
          .thenAnswer((_) async {
            final tokenizedHeader = await tokenManager.getTokenizedHeader();
            if (tokenizedHeader['token'] == token){
              return ApiResponseSuccess(data: []);
            }
            return ApiResponseFailed();
          }
        );
        GetIt.I.registerFactory(() => LihatStockBarangProvider(
          repository: mockBarangRepository
        ));

        await tester.pumpWidget(
          const MyApp(),
        );
        await tester.pump();
        await tester.tap(find.byType(SubmitButton));
        await tester.pump();
        expect(find.byType(DefaultErrorWidget) , findsNothing);

      }
  );
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

  when(() => mockLoginApiClient.login(any())).thenAnswer(
    (realInvocation) async{
      return Response(jsonBody, 200);
    },
  );

  return mockLoginApiClient;
}