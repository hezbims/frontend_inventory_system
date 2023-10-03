import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_api_response_until_complete.dart';

Future<void> terimaPengajuan({
  required WidgetTester tester
}) async {
  await tester.tap(find.text('Lihat Detail'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('Terima'));
  final mainFormProvider = GetIt.I.get<MainFormProvider>();
  await waitUntilApiResponseComplete(() => mainFormProvider.submitResponse);

  await tester.pumpAndSettle();

  expect(find.text('diterima'), findsOneWidget);
}