import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../extension_and_utils/wait_until_disappear.dart';

Future<void> lihatPdfLaporan({
  required WidgetTester tester,
  required IntegrationTestWidgetsFlutterBinding binding,
}) async {
  await tester.tap(find.text('Cetak Laporan'));
  await tester.waitUntilDisappear(
    find.descendant(
      of: find.byType(PreviewLaporanPage),
      matching: find.byType(CircularProgressIndicator)
    ),
  );

  await binding.convertFlutterSurfaceToImage();
  await tester.pumpAndSettle();
  await binding.takeScreenshot('test_screenshots/pdf_laporan_screenshot_1.png');
}