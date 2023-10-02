import 'package:dependencies/get_it.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../extension_and_utils/wait_api_response_until_complete.dart';

Future<void> logout({required WidgetTester tester}) async {
  await tester.tap(find.text('Logout'));

  final provider = GetIt.I.get<SettingAkunProvider>();
  await waitUntilApiResponseComplete(() => provider.logoutResponse);

  await tester.pumpAndSettle();
}