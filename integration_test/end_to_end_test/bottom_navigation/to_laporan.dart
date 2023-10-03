import 'package:flutter_test/flutter_test.dart';

Future<void> navigateToLaporan({
  required WidgetTester tester,
}) async {
  await tester.tap(find.text('Laporan'));
  await tester.pumpAndSettle();
}