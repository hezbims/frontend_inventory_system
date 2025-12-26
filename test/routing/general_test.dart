import 'dart:io';

import 'package:auth_test_support/mock/mock_auth_repository.dart';
import 'package:common/domain/feature/transaction/repository/i_transaction_repository.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/password_textfield.dart';
import 'package:common/response/api_response.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:common_test_support/mock/mock_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dependencies_test_support/mocktail.dart';
import 'package:inventory_system/main.dart';
import 'package:transaction_test_support/mock/mock_notification_repository.dart';
import 'package:transaction_test_support/mock/mock_transaction_repository.dart';

import '../common/mock/mock_user_repository.dart';
import '../fallback_value/register_my_app_fallback_values.dart';

void main(){
  tearDown(() async {
    debugDumpApp();
    await GetIt.I.reset();
  });

  testWidgets('When login succeed, the current route must be opened', (tester) async {
    await GetIt.I.reset();

    registerMyAppFallbackValues();

    final mockAuthRepository = MockAuthRepository();
    final mockTokenManager = MockTokenManager();
    final mockUserRepository = MockUserRepository();
    final mockTransactionRepository = MockTransactionRepository();
    final mockNotificationRepository = MockNotificationRepository();

    when(() => mockUserRepository.getUser()).thenAnswer((_) =>
      Future.value(ApiResponseFailed(statusCode: HttpStatus.unauthorized)));
    when(() => mockTransactionRepository.getTransactionPreviews(request: captureAny(named: 'request')))
    .thenAnswer((_) => Future.value(ResponseFailed(error: null)));
    when(() => mockNotificationRepository.getSseTransaction()).thenAnswer((_) async* {

    });

    GetIt.I.registerSingleton<ITokenManager>(mockTokenManager);
    GetIt.I.registerSingleton<ILoginRepository>(mockAuthRepository);
    GetIt.I.registerSingleton<IUserRepository>(mockUserRepository);
    GetIt.I.registerSingleton<ITransactionRepository>(mockTransactionRepository);
    GetIt.I.registerSingleton<INotificationRepository>(mockNotificationRepository);

    when(() => mockAuthRepository.login(captureAny())).thenAnswer((invocation) async {
      final loginData = invocation.positionalArguments.single as PostLoginDto;
      if (loginData.username == 'my_admin' && loginData.password == 'strong_Password_123') {
        return ApiResponseSuccess(
            data: User(
                token: 'some_token_123',
                username: 'my_admin',
                isAdmin: true,
                id: 1)
        );
      }

      throw ArgumentError('Unexpected username and password');
    }
    );
    when(() => mockTokenManager.setToken(captureAny())).thenAnswer((_) async {});

    final routeStateProvider = MyRouteStateProvider();
    routeStateProvider.setRouteState(RouteLihatPengajuanState());

    await tester.pumpWidget(
      MyApp(routeStateProvider: routeStateProvider,)
    );
    await tester.pumpAndSettle();
    expect(find.byType(LihatPengajuanScreen), findsNothing);

    final usernameTextField = find.descendant(
        of: find.widgetWithText(CustomTextfield, 'Username'),
        matching: find.byType(TextField));
    final passwordTextField = find.descendant(
        of: find.widgetWithText(PasswordTextfield, 'Password'),
        matching: find.byType(TextField));

    await tester.enterText(usernameTextField, 'my_admin');
    await tester.enterText(passwordTextField, 'strong_Password_123');
    await tester.tap(find.text('Submit'));

    await tester.pumpAndSettle();

    expect(find.byType(LihatPengajuanScreen), findsOneWidget);
  });
}