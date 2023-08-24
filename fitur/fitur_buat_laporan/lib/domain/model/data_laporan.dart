
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';

class DataLaporan {
  final String namaKategori;
  final List<TransaksiBarangSummary> barang;
  DataLaporan({
    required this.namaKategori,
    required this.barang,
  });
}