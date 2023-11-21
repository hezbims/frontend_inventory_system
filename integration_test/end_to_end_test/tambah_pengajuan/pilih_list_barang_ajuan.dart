import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_barang_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';
import 'pilih_sebuah_barang_ajuan.dart';

Future<void> pilihListBarangAjuan({
  required WidgetTester tester,
  required List<BarangTransaksi> listBarangAjuan,
}) async {
  await tester.tap(find.byType(TambahSesuatuButton));

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(PilihBarangScreen),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  for (var barangAjuan in listBarangAjuan) {
    await pilihSebuahBarangAjuan(tester: tester, barang: barangAjuan);
  }

  await tester.pageBack();
  await tester.pumpAndSettle();
}