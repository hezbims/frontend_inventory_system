import 'package:fitur_setting_akun/presentation/page/setting_akun_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';

Future<void> logout({required WidgetTester tester}) async {
  await tester.tap(find.text('Logout'));

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(SettingAkunScreen),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await tester.pumpAndSettle();
}