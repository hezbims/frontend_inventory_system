import 'package:common/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tambah_pengajuan_baru.dart';

Future<void> tambahPengajuanDariNonAdminCase({
  required WidgetTester tester,
}) async {
  await tambahPengajuanBaru(
    tester: tester,
    pengajuan: Pengajuan(
      id: null,
      tanggal: DateTime.now(),
      pengaju: Pengaju(
        nama: 'Grup 1',
        id: -1,
        isPemasok: false,
      ),
      status: null,
      listBarangTransaksi: [
        BarangTransaksi(
            id: -1,
            idBarang: -1,
            namaBarang: 'Barang 1',
            quantity: 4,
            keterangan: 'ngambil empat barang 1'
        ),
        BarangTransaksi(
            id: -1,
            idBarang: -1,
            namaBarang: 'Barang 2',
            quantity: 3,
            keterangan: ''
        ),
      ],
    ),
  );
}