import 'package:common/domain/model/kategori.dart';

class Barang {
  final String? id;
  final String nama;
  final int minStock;
  final String nomorRak;
  final int stockSekarang;
  final int lastMonthStock;
  final int unitPrice;
  final Kategori kategori;
  final String? urlPhoto;
  Barang({
    required this.id,
    required this.nama,
    required this.minStock,
    required this.nomorRak,
    required this.stockSekarang,
    required this.lastMonthStock,
    required this.unitPrice,
    required this.kategori,
    this.urlPhoto,
  });
}