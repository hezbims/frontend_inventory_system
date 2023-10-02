// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/model/rak.dart';
import 'package:common/presentation/button/submit_button.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:common/presentation/textfield/dropdown_page_chooser.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';
import 'package:fitur_input_data_barang/presentation/provider/input_data_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stock_bu_fan/dependency_injection/setup_di.dart';
import 'package:stock_bu_fan/main.dart';

import '../test/testing_api_client.dart';

extension WidgetTesterExtension on WidgetTester {
  Future<void> typeTextField({
    required String textFieldLabel,
    required String input,
  }) async {
    final customColumnTextField = find.widgetWithText(Column, textFieldLabel);
    expect(customColumnTextField, findsOneWidget);

    final textField = find.descendant(
      of: customColumnTextField,
      matching: find.byType(TextField)
    );

    final scrollable = find.byType(ListView);

    await dragUntilVisible(textField, scrollable, const Offset(0, -50));
    await enterText(textField, input);

  }
}
// Bakal ngegunain production environment
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // const shortTimePump = Duration(milliseconds: 200);

  Future<void> waitUntilApiResponseComplete(
    ApiResponse? Function() getApiResponse,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));
    while (getApiResponse() is ApiResponseLoading){
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> prepareDatabase() async {
    final testApiClient = TestingApiClient();
    final resetDatabaseResponse = await testApiClient.resetDatabase();
    expect(resetDatabaseResponse.statusCode, 200);

    final buatDuaUserResponse = await testApiClient.buatDuaUser();
    expect(buatDuaUserResponse.statusCode , 200);
  }

  Future<void> inputDanPilihKategori({
      required String namaKategori,
      required WidgetTester tester,
  }) async {
    // entah kenapa kalo tanpa pump and settle, dropdown kategori bisa didapat
    // tapi pas di tap, enggak navigate
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownPageChooser));

    await tester.pumpAndSettle();

    await tester.tap(find.byType(TambahSesuatuButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, namaKategori);
    await tester.tap(find.byType(SubmitButton));

    final KategoriDialogProvider provider = GetIt.I.get();
    await waitUntilApiResponseComplete(() => provider.submitResponse);

    await tester.pumpAndSettle();
    await tester.tap(find.text(namaKategori));
    await tester.pumpAndSettle();
  }

  Future<void> inputBarang({
    required Barang data,
    required WidgetTester tester,
  }) async {
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.typeTextField(
        textFieldLabel: 'Nama',
        input: data.nama
    );
    await inputDanPilihKategori(
      namaKategori : data.kategori.nama,
      tester: tester,
    );
    await tester.typeTextField(
        textFieldLabel: 'Nomor Rak',
        input: data.rak.nomorRak.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Nomor Laci',
        input: data.rak.nomorLaci.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Nomor Kolom',
        input: data.rak.nomorKolom.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Min. Stock',
        input: data.minStock.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Last Month Stock',
        input: data.lastMonthStock.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Stock Sekarang',
        input: data.stockSekarang.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'Unit Price',
        input: data.unitPrice.toString()
    );
    await tester.typeTextField(
        textFieldLabel: 'UOM',
        input: data.uom
    );

    final submitButtonFinder = find.byType(SubmitButton);
    await tester.dragUntilVisible(submitButtonFinder, find.byType(ListView), const Offset(0, -50));
    await tester.tap(submitButtonFinder);

    final provider = GetIt.I.get<InputDataBarangProvider>();
    await waitUntilApiResponseComplete(() => provider.submitResponse);
    await tester.pumpAndSettle();
  }

  Future<void> login({
    required WidgetTester tester,
    required String username,
    required String password,
  }) async {
    final userProvider = GetIt.I.get<UserProvider>();
    await userProvider.getUserResponse;
    await tester.pump();
    await tester.enterText(find.byType(TextField).first, username);
    await tester.enterText(find.byType(TextField).last, password);

    await tester.tap(find.byType(SubmitButton));
    final loginProvider = GetIt.I.get<LoginProvider>();
    await waitUntilApiResponseComplete(() => loginProvider.loginResponse);
  }

  Future<void> inputDuaBarang({required WidgetTester tester}) async {
    // load home screen setelah navigate
    await tester.pumpAndSettle();

    // Mencoba input barang baru
    await inputBarang(
        data: Barang(
          id: -1,
          kodeBarang: "",
          nama: 'Barang 1',
          minStock: 2,
          rak: Rak(
              nomorRak: 2,
              nomorLaci: 3,
              nomorKolom: 4
          ),
          stockSekarang: 25,
          lastMonthStock: 10,
          unitPrice: 2500,
          kategori: Kategori(id: -1, nama: 'Kategori 1'),
          uom: 'Liter',
        ),
        tester: tester
    );
    await inputBarang(
        data: Barang(
          id: -1,
          kodeBarang: "",
          nama: 'Barang 2',
          minStock: 2,
          rak: Rak(
              nomorRak: 2,
              nomorLaci: 3,
              nomorKolom: 5
          ),
          stockSekarang: 20,
          lastMonthStock: 10,
          unitPrice: 3000,
          kategori: Kategori(id: -1, nama: 'Kategori 2'),
          uom: 'Pc',
        ),
        tester: tester
    );
  }

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    setupMainDependencyInjection();
    await prepareDatabase();

    await tester.pumpWidget(const MyApp());

    await login(tester: tester , username: 'admin' , password: '123');
    await inputDuaBarang(tester: tester);

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));

    // await tester.tap(find.text('Transaksi'));
    // await tester.pumpAndSettle();
    //
    // await tester.tap(find.byType(FloatingActionButton));
    // await tester.pumpAndSettle();
  });
}
