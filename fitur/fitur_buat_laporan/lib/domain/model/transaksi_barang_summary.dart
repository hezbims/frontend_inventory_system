class TransaksiBarangSummary {
  // TODO : Nanti tambahin kolom untuk current sama amount, biar business logic dipindahin ke backend
  final String kodeBarang;
  final int nomorRak;
  final int nomorLaci;
  final int nomorKolom;
  final String namaBarang;
  final String uom;
  final int minStock;
  final int lastMonthStock;
  final int currentStock;
  final int totalMasuk;
  final int totalKeluar;
  final int unitPrice;
  final int amount;

  TransaksiBarangSummary({
    required this.kodeBarang,
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
    required this.namaBarang,
    required this.uom,
    required this.minStock,
    required this.lastMonthStock,
    required this.currentStock,
    required this.totalMasuk,
    required this.totalKeluar,
    required this.unitPrice,
    required this.amount,
  });

  String get lokasiRak => "R$nomorRak-$nomorLaci-$nomorKolom";
}