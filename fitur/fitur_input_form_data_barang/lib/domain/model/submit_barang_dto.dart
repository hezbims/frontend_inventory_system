class SubmitBarangDto {
  final int? id;
  final String nama;
  final int? minStock;
  final int? nomorRak;
  final int? nomorLaci;
  final int? nomorKolom;
  final int? stockSekarang;
  final int? lastMonthStock;
  final int? unitPrice;
  final int? idKategori;
  final String uom;

  SubmitBarangDto({
    required this.id,
    required this.nama,
    required this.minStock,
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
    required this.stockSekarang,
    required this.lastMonthStock,
    required this.unitPrice,
    required this.idKategori,
    required this.uom,
  });

  Map<String , Object?> toJson(){
    final Map<String , Object?>result = {
      kolomId : id,
      kolomNama : nama,
      kolomMinStock : minStock,
      kolomNomorRak : nomorRak,
      kolomNomorLaci : nomorLaci,
      kolomNomorKolom : nomorKolom,
      kolomStockSekarang : stockSekarang,
      kolomLastMonthStock : lastMonthStock,
      kolomUnitPrice : unitPrice,
      kolomIdKategori : idKategori,
      kolomUom : uom,
    };

    return result;
  }

  static const kolomId = "id";
  static const kolomNama = "nama";
  static const kolomMinStock = 'min_stock';
  static const kolomNomorRak = 'nomor_rak';
  static const kolomNomorLaci = 'nomor_laci';
  static const kolomNomorKolom = 'nomor_kolom';
  static const kolomStockSekarang = 'stock_sekarang';
  static const kolomLastMonthStock = 'last_month_stock';
  static const kolomUnitPrice = 'unit_price';
  static const kolomIdKategori = 'kategori_id';
  static const kolomUom = 'uom';
}