import 'package:common/domain/model/transaksi.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String tanggal;
  final String jam;
  final String? section;
  final String tipe;
  final List<Transaksi> listTransaksi;
  Pengajuan({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.jam,
    required this.section,
    required this.tipe,
    this.listTransaksi = const [],
  });
}