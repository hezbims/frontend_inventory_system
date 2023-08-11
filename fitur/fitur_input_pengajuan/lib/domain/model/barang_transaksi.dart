import 'package:common/domain/model/barang.dart';

class BarangTransaksi {
  final Barang barang;
  final int quantity;
  final String keterangan;
  BarangTransaksi({
    required this.barang,
    required this.quantity,
    required this.keterangan,
  });
}