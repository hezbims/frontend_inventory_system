import 'package:common/presentation/button/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';

Future<void> login({
  required WidgetTester tester,
  required String username,
  required String password,
}) async {
  await tester.waitUntilDisappear(find.byType(CircularProgressIndicator));
  await tester.enterText(find.byType(TextField).first, username);
  await tester.enterText(find.byType(TextField).last, password);

  await tester.tap(find.byType(SubmitButton));
  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(FilledButton),
      matching: find.byType(CircularProgressIndicator),
    )
  );
}