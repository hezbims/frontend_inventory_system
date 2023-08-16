import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/model/rak.dart';

class Barang {
  final String id;
  final String nama;
  final int minStock;
  final Rak rak;
  final int stockSekarang;
  final int lastMonthStock;
  final int unitPrice;
  final Kategori kategori;
  final String? urlPhoto;
  Barang({
    required this.id,
    required this.nama,
    required this.minStock,
    required this.rak,
    required this.stockSekarang,
    required this.lastMonthStock,
    required this.unitPrice,
    required this.kategori,
    this.urlPhoto,
  });

  factory Barang.fromJson(Map<String , dynamic> json){
    return Barang(
        id: json['id'],
        nama: json['nama'],
        minStock: json['min_stock'],
        rak: Rak.fromjson(json['rak']),
        stockSekarang: json['stock_sekarang'],
        lastMonthStock: json['last_month_stock'],
        unitPrice: json['unit_price'],
        kategori: json['kategori'],
    );
  }
}