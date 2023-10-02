import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'inputkan_data_pengajuan_ke_form.dart';

Future<void> tambahPengajuanBaru({
  required WidgetTester tester,
  required Pengajuan pengajuan,
}) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  await inputkanDataPengajuanKeForm(
      tester: tester,
      data: pengajuan
  );
}