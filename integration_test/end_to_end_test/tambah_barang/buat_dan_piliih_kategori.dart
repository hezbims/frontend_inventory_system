import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_until_disappear.dart';

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

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(SubmitButton),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(PilihKategoriPage),
      matching: find.byType(CircularProgressIndicator)
    )
  );

  await tester.tap(find.text(namaKategori));
  await tester.pumpAndSettle();
}