import 'package:flutter_test/flutter_test.dart';

Future<void> navigateToSettingAkunPage({required WidgetTester tester}) async{
  await tester.tap(find.text('Akun'));
  await tester.pumpAndSettle();
}