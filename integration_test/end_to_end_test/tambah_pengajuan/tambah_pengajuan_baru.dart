import 'package:common/presentation/button/submit_button.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';
import 'inputkan_semua_data_pengajuan.dart';

Future<void> tambahPengajuanBaru({
  required WidgetTester tester,
  required Pengajuan pengajuan,
}) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  await inputkanSemuaDataPengajuan(
      tester: tester,
      data: pengajuan
  );

  await tester.tap(find.byType(SubmitButton));

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(MainForm),
      matching: find.byType(CircularProgressIndicator)
    ),
  );
}