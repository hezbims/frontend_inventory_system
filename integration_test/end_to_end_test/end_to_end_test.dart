// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stock_bu_fan/dependency_injection/setup_di.dart';
import 'package:stock_bu_fan/main.dart';

import 'bottom_navigation/to_pengajuan.dart';
import 'bottom_navigation/to_setting_akun.dart';
import 'extension_and_utils/prepare_database.dart';
import 'login/login.dart';
import 'setting_akun/logout.dart';
import 'tambah_barang/input_dua_barang_case.dart';
import 'tambah_pengajuan/tambah_pengajuan_dari_non_admin_case.dart';

// Bakal ngegunain production environment
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    setupMainDependencyInjection();
    await prepareDatabase();

    await tester.pumpWidget(const MyApp());

    await login(tester: tester , username: 'admin' , password: '123');
    await inputDuaBarang(tester: tester);
    await navigateToSettingAkunPage(tester: tester);
    await logout(tester: tester);
    await login(tester: tester, username: 'hezbi', password: '123');
    await navigateToPengajuanPage(tester: tester);
    await tambahPengajuanDariNonAdminCase(tester: tester);
    await navigateToSettingAkunPage(tester: tester);
    await logout(tester: tester);
    await login(tester: tester, username: 'admin', password: '123');
    await navigateToPengajuanPage(tester: tester);

  });
}
