import 'package:dependencies/get_it.dart';
import 'package:fitur_buat_laporan/presentation/provider/preview_laporan_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<void> lihatPdfLaporan({
  required WidgetTester tester,
  required IntegrationTestWidgetsFlutterBinding binding,
}) async {
  await tester.tap(find.text('Cetak Laporan'));
  await tester.pumpAndSettle();

  final previewLaporanProvider = GetIt.I.get<PreviewLaporanProvder>();
  await previewLaporanProvider.dataLaporanResponse;

  await binding.convertFlutterSurfaceToImage();
  await tester.pumpAndSettle();
  await binding.takeScreenshot('test_screenshots/pdf_laporan_screenshot_1.png');
}