import 'package:common/presentation/button/submit_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_api_response_until_complete.dart';
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

  final submitPengajuanProvider = GetIt.I.get<MainFormProvider>();
  await waitUntilApiResponseComplete(() => submitPengajuanProvider.submitResponse);
  await tester.pumpAndSettle();
}