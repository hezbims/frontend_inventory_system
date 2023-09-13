
import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/component/main_form/barang_field.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mock.dart';

void main() {
  testWidgets('List Barang dan Grup/Pemasok terdisplay sesuai dengan tipe pengaju',
    (tester) async {
      GetIt.I.registerSingleton<ISubmitPengajuanRepository>(MockSubmitPengajuanRepository());
      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
              child: MainForm(
                initialData: Pengajuan(
                  id: null,
                  tanggal: DateTime.now(),
                  pengaju: null,
                ),
              ),
          ),
        ),
      );

      // pastiin field gak ada kalo pengaju belum dipilih
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
      await tester.tap(find.byType(Scaffold));
      await tester.pump();

      expect(find.text("Nama pemasok"), findsNothing);
      expect(find.text("Group"), findsOneWidget);
      expect(find.byType(ListBarangFormField), findsOneWidget);
  });
}
