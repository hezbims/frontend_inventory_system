import 'package:common/domain/model/group.dart';
import 'package:common/domain/model/transaksi.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String tanggal;
  final String jam;
  final Group group;
  final String tipe;
  final List<Transaksi> listTransaksi;
  Pengajuan({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.jam,
    required this.group,
    required this.tipe,
    this.listTransaksi = const [],
  });
}