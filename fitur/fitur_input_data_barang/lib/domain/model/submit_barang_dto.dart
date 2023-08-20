class SubmitBarangDto {
  final Map<String , String> json;
  SubmitBarangDto({
    required String? id,
    required String nama,
    required String minStock,
    required String nomorRak,
    required String nomorLaci,
    required String nomorKolom,
    required String stockSekarang,
    required String lastMonthStock,
    required String unitPrice,
    required String idKategori,
    required String uom,
  }) :
      json = {
        kolomId : id ?? "",
        kolomNama : nama,
        kolomMinStock : minStock,
        kolomNomorRak : nomorRak,
        kolomNomorLaci : nomorLaci,
        kolomNomorKolom : nomorKolom,
        kolomCreateRak : "",
        kolomStockSekarang : stockSekarang,
        kolomLastMonthStock : lastMonthStock,
        kolomUnitPrice : unitPrice,
        kolomIdKategori : idKategori,
        kolomUom : uom,
      };

  static const kolomId = "id";
  static const kolomNama = "nama";
  static const kolomMinStock = 'min_stock';
  static const kolomNomorRak = 'nomor_rak';
  static const kolomNomorLaci = 'nomor_laci';
  static const kolomCreateRak = 'create_rak';
  static const kolomNomorKolom = 'nomor_kolom';
  static const kolomStockSekarang = 'stock_sekarang';
  static const kolomLastMonthStock = 'last_month_stock';
  static const kolomUnitPrice = 'unit_price';
  static const kolomIdKategori = 'id_category';
  static const kolomUom = 'uom';
}