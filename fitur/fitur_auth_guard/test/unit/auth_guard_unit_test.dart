

import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/dependency_injection/fitur_auth_guard_di.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extensions/wait_until_disappear.dart';

void main(){
  testWidgets(
    'Ketika passwordname dan username yang dimasukkan tidak cocok, '
    'Maka pesan error akan terdisplay',
    (tester) async {
      GetIt.I.registerSingleton<ITokenManager>(TokenManagerImpl());
      fiturAuthGuardDi();
      tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.tap(find.byType(SubmitButton));
      await tester.waitUntilDisappear(
        find.descendant(
          of: find.byType(LoginScreen),
          matching: find.byType(CircularProgressIndicator)),
      );
      //expect(find.text(text), findsOneWidget);
    },
  );
}

