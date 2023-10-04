import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_until_disappear.dart';

Future<void> logout({required WidgetTester tester}) async {
  await tester.tap(find.text('Logout'));

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(SettingAkunPage),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await tester.pumpAndSettle();
}