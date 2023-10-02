import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_api_response_until_complete.dart';

Future<void> login({
  required WidgetTester tester,
  required String username,
  required String password,
}) async {
  final userProvider = GetIt.I.get<UserProvider>();
  await userProvider.getUserResponse;
  await tester.pump();
  await tester.enterText(find.byType(TextField).first, username);
  await tester.enterText(find.byType(TextField).last, password);

  await tester.tap(find.byType(SubmitButton));
  final loginProvider = GetIt.I.get<LoginProvider>();
  await waitUntilApiResponseComplete(() => loginProvider.loginResponse);

  // load home screen setelah navigate
  await tester.pumpAndSettle();
}