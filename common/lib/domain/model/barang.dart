import 'package:common/domain/model/kategori.dart';

class Barang {
  final int id;
  final String kodeBarang;
  final String nama;
  final int nomorRak;
  final int nomorLaci;
  final int nomorKolom;
  final int minStock;
  final int stockSekarang;
  final int lastMonthStock;
  final int unitPrice;
  final Kategori kategori;
  final String? urlPhoto;
  final String uom;
  Barang({
    required this.id,
    required this.kodeBarang,
    required this.nama,
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
    required this.minStock,
    required this.stockSekarang,
    required this.lastMonthStock,
    required this.unitPrice,
    required this.kategori,
    required this.uom,
    this.urlPhoto,
  });


  static const _kolomId = 'id';
  static const _kolomNama = 'nama';
  static const _kolomMinStock = 'min_stock';
  static const _kolomNomorRak = 'nomor_rak';
  static const _kolomNomorLaci = 'nomor_laci';
  static const _kolomNomorKolom = 'nomor_kolom';
  static const _kolomStockSekarang = 'stock_sekarang';
  static const _kolomLastMonthStock = 'last_month_stock';
  static const _kolomUnitPrice = 'unit_price';
  static const _kolomKategori = 'kategori';
  static const _kolomUom = "uom";
  static const _kolomKodeBarang = 'kode_barang';

  factory Barang.fromJson(Map<String , dynamic> json){
    return Barang(
        id: json[_kolomId],
        kodeBarang: json[_kolomKodeBarang],
        nama: json[_kolomNama],
        minStock: json[_kolomMinStock],
        nomorRak: json[_kolomNomorRak],
        nomorLaci: json[_kolomNomorLaci],
        nomorKolom: json[_kolomNomorKolom],
        stockSekarang: json[_kolomStockSekarang],
        lastMonthStock: json[_kolomLastMonthStock],
        unitPrice: json[_kolomUnitPrice],
        kategori: Kategori.fromJson(json[_kolomKategori]),
        uom: json[_kolomUom],
    );
  }

  Map<String , dynamic> toJson(){
    return {
      _kolomId : id,
      _kolomNama : nama,
      _kolomMinStock : minStock,
      _kolomNomorRak : nomorRak,
      _kolomNomorLaci : nomorLaci,
      _kolomNomorKolom : nomorKolom,
      _kolomStockSekarang : stockSekarang,
      _kolomLastMonthStock : lastMonthStock,
      _kolomUnitPrice : unitPrice,
      _kolomKategori : kategori.toJson(),
      _kolomUom : uom,
    };
  }
}