import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_provider.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants/constants.dart';
import '../extension_and_utils/wait_api_response_until_complete.dart';

Future<void> inputDanPilihKategori({
  required String namaKategori,
  required WidgetTester tester,
}) async {
  // entah kenapa kalo tanpa pump and settle, dropdown kategori bisa didapat
  // tapi pas di tap, enggak navigate
  await tester.pumpAndSettle();
  await tester.tap(find.byType(DropdownPageChooser));

  await tester.pumpAndSettle();

  await tester.tap(find.byType(TambahSesuatuButton));
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField).last, namaKategori);
  await tester.tap(find.byType(SubmitButton));

  final KategoriDialogProvider provider = GetIt.I.get();
  await waitUntilApiResponseComplete(() => provider.submitResponse);

  await tester.pumpAndSettle(shortTimePump);

  final PilihKategoriProvider pilihKategoriProvider = GetIt.I.get();
  await pilihKategoriProvider.getFilteredKategori();

  await tester.tap(find.text(namaKategori));
  await tester.pumpAndSettle();
}