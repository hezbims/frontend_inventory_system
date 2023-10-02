import 'package:common/domain/model/pengaju.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/buat_pengaju_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/pilih_pengaju_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_api_response_until_complete.dart';

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

  final buatPengajuProvider = GetIt.I.get<BuatPengajuProvider>();
  waitUntilApiResponseComplete(() => buatPengajuProvider.submitResponse);
  await tester.pumpAndSettle();

  final pilihPengajuProvider = GetIt.I.get<PilihPengajuProvider>();
  await pilihPengajuProvider.filteredGroupResponse;
  await tester.pump();

  await tester.tap(find.widgetWithText(Card, pengaju.nama));
  await tester.pump();
  await Future.delayed(const Duration(seconds: 5));
}