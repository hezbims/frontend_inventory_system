import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import 'pilih_sebuah_barang_ajuan.dart';

Future<void> pilihListBarangAjuan({
  required WidgetTester tester,
  required List<BarangTransaksi> listBarangAjuan,
}) async {
  await tester.tap(find.byType(TambahSesuatuButton));
  await tester.pumpAndSettle();

  final pilihBarangAjuanProvider = GetIt.I.get<PilihBarangProvider>();
  await pilihBarangAjuanProvider.pageRequestProcess;
  await tester.pump();

  for (var barangAjuan in listBarangAjuan) {
    await pilihSebuahBarangAjuan(tester: tester, barang: barangAjuan);
  }

  await tester.pageBack();
  await tester.pumpAndSettle();
}