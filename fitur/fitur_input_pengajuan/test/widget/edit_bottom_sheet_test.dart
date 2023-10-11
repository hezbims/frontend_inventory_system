import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/button/cancel_button.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/barang_quantity_incrementer.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock_submit_pengajuan_repository.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  // Men-test proses edit
  testWidgets(
    'diberikan sebuah main form dengan 2 buah barang ajuan '
    'ketika user menekan tombol edit pada barang ajuan pertama, lalu '
    'ketika menginputkan quantity, lalu menginputkan keterangan yang valid lalu menekan enter '
    'maka barang akan teredit sesuai quantity dan keterangan yang barusan ditulis ',
    (tester) async {

      await tester.pumpWidget(siapkanMainFormDenganDuaBarangAjuan());

      const newQuantity = 121;
      const newKeterangan = 'halo';

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.descendant(
          of: find.byType(BarangQuantityIncrementer),
          matching: find.byType(TextField)
        ),
        newQuantity.toString()
      );

      await tester.enterText(
        find.descendant(
          of: find.widgetWithText(CustomTextfield, 'Keterangan'),
          matching: find.byType(TextField)
        ),
        newKeterangan
      );

      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text('Keterangan : $newKeterangan'), findsOneWidget);
      expect(find.text('Quantity : $newQuantity'), findsOneWidget);
    } , tags: [TestTags.fastTest]
  );

  testWidgets(
    'Diberikan sebuah main form dengan dua buah barang ajuan '
    'ketika tombol tong sampah terakhir di klik, '
    'maka barang terakhir akan hilang ',
    (tester) async {
      await tester.pumpWidget(siapkanMainFormDenganDuaBarangAjuan());

      await tester.ensureVisible(find.byIcon(Icons.delete).last);
      await tester.pump();
      await tester.tap(
          find.byIcon(Icons.delete).last,
      );
      await tester.pump();

      expect(find.text('barang-2'), findsNothing);
    } , tags: [TestTags.fastTest]
  );

  // ngatasin bug sebelumnya yang gak bisa ngedit dua kali
  testWidgets(
    'Diberikan sebuah main form '
    'ketika user mencoba klik edit barang pertama '
    'lalu cancel '
    'lalu coba edit pertama lagi '
    'lalu cancel lagi '
    'maka semua proses berjalan tanpa error dan barang tetap tidak teredit',
    (tester) async {
      await tester.pumpWidget(siapkanMainFormDenganDuaBarangAjuan());

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CancelButton));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CancelButton));
      await tester.pumpAndSettle();

      expect(find.text('Keterangan : ket-1'), findsOneWidget);
      expect(find.text('Quantity : 9'), findsOneWidget);
    } , tags: [TestTags.fastTest]
  );

  testWidgets(
    'Diberikan main form dengan dua barang ajuan '
    'Ketika user mencoba mengedit dengan quantity yang tidak valid '
    'Maka error akan terdisplay di bawah field quantity ',
    (tester) async {
      await tester.pumpWidget(siapkanMainFormDenganDuaBarangAjuan());

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.descendant(
          of: find.byType(BarangQuantityIncrementer),
          matching: find.byType(TextField)
        ),
        'xyz'
      );
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(
        find.widgetWithText(BarangQuantityIncrementer , "Quantity tidak valid"),
        findsOneWidget
      );
    } , tags: [TestTags.fastTest]
  );
}

Widget siapkanMainFormDenganDuaBarangAjuan(){
  return MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: MockMainFormDependencySetup(),
    ),
  );
}

class MockMainFormDependencySetup extends GetItDependencySetup{
  MockMainFormDependencySetup({
    super.key,
  }) : super(
    setup: (){
      GetIt.I.registerSingleton(
        MainFormProvider(
          user: User(token: '', username: 'bukan-admin', isAdmin: false, id: 1),
          initialData: Pengajuan(
            id: 1,
            tanggal: DateTime(2023),
            pengaju: Pengaju(nama: 'budi', id: 1, isPemasok: false),
            status: StatusPengajuan.menunggu,
            listBarangTransaksi: [
              BarangTransaksi(id: 1, idBarang: 1, namaBarang: 'barang-1', quantity: 9, keterangan: 'ket-1'),
              BarangTransaksi(id: 2, idBarang: 2, namaBarang: 'barang-2', quantity: 100, keterangan: 'ket-2'),
            ],
          ),
          repository: MockSubmitPengajuanRepository()
        ),
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<MainFormProvider>();
    },
    page: MainForm(),
  );
}