import 'package:flutter_test/flutter_test.dart';

Future<void> navigateToPengajuanPage({required WidgetTester tester}) async {
  await tester.tap(find.text('Transaksi'));
  await tester.pumpAndSettle();
}