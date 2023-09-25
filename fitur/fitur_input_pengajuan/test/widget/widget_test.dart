import 'package:common/constant/test_tags/test_tags.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/barang_field.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock.dart';

void main() {
  testWidgets('List Barang dan Grup/Pemasok terdisplay sesuai dengan tipe pengaju',
    (tester) async {
      GetIt.I.registerSingleton<ISubmitPengajuanRepository>(MockSubmitPengajuanRepository());
      GetIt.I.registerSingleton(User(token: '', username: '', isAdmin: true, id: 1));
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
              child: MainForm(
                initialData: Pengajuan(
                  id: null,
                  tanggal: DateTime.now(),
                  pengaju: null,
                  status: null,
                ),
              ),
          ),
        ),
      );

      // pastiin field pemasok, group, dan pemilihan barang gak ada gak ada kalo pengaju belum dipilih
      expect(find.text("Nama pemasok"), findsNothing);
      expect(find.text("Group"), findsNothing);
      expect(find.byType(ListBarangFormField), findsNothing);

      // Pilih tipe pengajuannya pemasukan
      await tester.tap(find.byType(CustomDropdownMenu<String>));
      await tester.pump();
      await tester.tap(find.text('Pemasukan'));
      await tester.pump();

      expect(find.text("Nama pemasok"), findsOneWidget);
      expect(find.text("Group"), findsNothing);
      expect(find.byType(ListBarangFormField), findsOneWidget);

      // Pilih tipe pengajuannya pengeluaran
      await tester.tap(find.byType(CustomDropdownMenu<String>));
      await tester.pump();
      await tester.tap(find.text('Pengeluaran'));
      await tester.pump();

      expect(find.text("Nama pemasok"), findsNothing);
      expect(find.text("Group"), findsOneWidget);
      expect(find.byType(ListBarangFormField), findsOneWidget);

      // Tap outside (enggak milih apa-apa), expectnya bakal gak ada yang berubah, sama kayak sebelumnya
      await tester.tap(find.byType(CustomDropdownMenu<String>));
      await tester.pump();
      await tester.tap(find.text("Form Input Transaksi") , warnIfMissed: false);
      await tester.pump();

      expect(find.text("Nama pemasok"), findsNothing);
      expect(find.text("Group"), findsOneWidget);
      expect(find.byType(ListBarangFormField), findsOneWidget);
  } , tags: [TestTags.fastTest]);

  testWidgets('ketika bottom sheet pertama kali dibuka, maka need focus, '
      'namun yang kedua maka tidak perlu focus' , (tester) async {
    final bottomSheetProvider = GetIt.I.registerSingleton(BottomSheetBarangProvider());
    await tester.pumpWidget(prepareTransaksiBarangBottomSheet());

    expect(bottomSheetProvider.quantityFocusNode.hasFocus, isTrue);

    final keteranganField = find.byType(TextField).last;
    await tester.tap(keteranganField);
    expect(bottomSheetProvider.quantityFocusNode.hasFocus, isFalse);
  } , tags: [TestTags.fastTest]);
}

Widget prepareTransaksiBarangBottomSheet(){
  return MaterialApp(
    home: Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: TransaksiBarangBottomSheet(
          initialBarangTransaksi: BarangTransaksi(
              id: 1,
              idBarang: 1,
              namaBarang: 'Mata Solder',
              quantity: 2,
              keterangan: ''
          ),
        ),
      ),
    ),
  );
}