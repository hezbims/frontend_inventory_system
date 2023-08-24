class TransaksiBarangSummary {
  final int nomorRak;
  final int nomorLaci;
  final int nomorKolom;
  final String namaBarang;
  final String uom;
  final int minStock;
  final int lastMonthStock;
  final int totalMasuk;
  final int totalKeluar;
  final int unitPrice;

  TransaksiBarangSummary({
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
    required this.namaBarang,
    required this.uom,
    required this.minStock,
    required this.lastMonthStock,
    required this.totalMasuk,
    required this.totalKeluar,
    required this.unitPrice,
  });
}