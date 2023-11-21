import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:fitur_input_form_data_barang/presentation/page/input_data_barang_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/cusom_widget_tester_extension.dart';
import 'package:common/utils/tester_wait_until_disappear.dart';
import 'buat_dan_piliih_kategori.dart';

Future<void> inputDataBarangKeForm({
  required Barang data,
  required WidgetTester tester,
}) async {
  await tester.tap(find.byType(FloatingActionButton).first);
  await tester.pumpAndSettle();

  await tester.typeTextField(
      textFieldLabel: 'Nama',
      input: data.nama
  );
  await inputDanPilihKategori(
    namaKategori : data.kategori.nama,
    tester: tester,
  );
  await tester.typeTextField(
      textFieldLabel: 'Nomor Rak',
      input: data.nomorRak.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Nomor Laci',
      input: data.nomorLaci.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Nomor Kolom',
      input: data.nomorKolom.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Min. Stock',
      input: data.minStock.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Last Month Stock',
      input: data.lastMonthStock.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Stock Sekarang',
      input: data.stockSekarang.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'Unit Price',
      input: data.unitPrice.toString()
  );
  await tester.typeTextField(
      textFieldLabel: 'UOM',
      input: data.uom
  );

  final submitButtonFinder = find.byType(SubmitButton);
  await tester.dragUntilVisible(submitButtonFinder, find.byType(ListView), const Offset(0, -50));
  await tester.tap(submitButtonFinder);

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(InputDataBarangScreen),
      matching: find.byType(CircularProgressIndicator)
    )
  );
}