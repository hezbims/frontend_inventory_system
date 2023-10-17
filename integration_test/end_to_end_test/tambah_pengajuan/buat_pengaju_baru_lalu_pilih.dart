import 'package:common/domain/model/pengaju.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_pengaju/show_buat_pengaju_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:common/utils/tester_wait_until_disappear.dart';

Future<void> buatPengajuBaruLaluPilih({
  required WidgetTester tester,
  required Pengaju pengaju,
}) async {
  await tester.tap(find.byType(DropdownPageChooser));
  await tester.pumpAndSettle();
  await tester.tap(find.byType(TambahSesuatuButton));
  await tester.pumpAndSettle();

  final textField = find.descendant(
      of: find.widgetWithText(
          CustomTextfield,
          "Nama ${pengaju.isPemasok ? 'pemasok' : 'group'}"
      ),
      matching: find.byType(TextField)
  );
  expect(textField, findsOneWidget);

  await tester.enterText(
    textField,
    pengaju.nama,
  );

  await tester.tap(find.byType(SubmitButton));

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(BuatPengajuBaruDialog),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(PilihPengajuPage),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await tester.tap(find.widgetWithText(Card, pengaju.nama));
  await tester.pumpAndSettle();
}