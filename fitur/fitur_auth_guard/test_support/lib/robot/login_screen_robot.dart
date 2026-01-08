import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/password_textfield.dart';
import 'package:common_test_support/extension/waiter_extension.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class LoginScreenRobot {
  final WidgetTester tester;
  LoginScreenRobot(this.tester);

  Future<void> loginWith({required String username, required String password}) async {
    final usernameTextField = find.descendant(
        of: find.widgetWithText(CustomTextfield, 'Username'),
        matching: find.byType(TextField));
    final passwordTextField = find.descendant(
        of: find.widgetWithText(PasswordTextfield, 'Password'),
        matching: find.byType(TextField));

    await tester.enterText(usernameTextField, 'my_admin');
    await tester.enterText(passwordTextField, 'strong_Password_123');
    await tester.tap(find.text('Submit'));
    await tester.pump();

    await tester.waitUntilDisappear(find.descendant(
      of: find.byType(LoginScreen),
      matching: find.byType(CircularProgressIndicator),
    ));
  }
}