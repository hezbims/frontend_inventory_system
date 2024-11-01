import 'package:fitur_input_pengajuan/presentation/pages/main_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';

Future<void> terimaPengajuan({
  required WidgetTester tester
}) async {
  await tester.tap(find.text('Lihat Detail'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Terima'));
  await tester.waitUntilDisappear(
    find.descendant(
        of: find.byType(MainFormScreen),
        matching: find.byType(CircularProgressIndicator)
    ),
  );

  expect(find.text('diterima'), findsOneWidget);
}