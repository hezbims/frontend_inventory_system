import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/barang_quantity_incrementer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pilihSebuahBarangAjuan({
  required WidgetTester tester,
  required BarangTransaksi barang,
}) async {
  await tester.tap(find.text(barang.namaBarang));
  await tester.pumpAndSettle();

  await tester.enterText(
    find.descendant(
      of: find.byType(BarangQuantityIncrementer),
      matching: find.byType(TextField)
    ),
    barang.quantity.toString(),
  );

  if (barang.keterangan?.isNotEmpty == true) {
    await tester.enterText(
      find.descendant(
        of: find.widgetWithText(CustomTextfield, 'Keterangan'),
        matching: find.byType(TextField),
      ),
      barang.keterangan!,
    );
  }

  await tester.tap(find.byType(SubmitButton));
  await tester.pumpAndSettle();
}