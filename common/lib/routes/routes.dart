abstract class Routes {
  static const fiturLihatStockBarangRoute = "/stock-barang";
  static const fiturLihatStockBarangIndex = 0;

  static const fiturInputDataBarangRoute = "$fiturLihatStockBarangRoute/input";

  static const fiturLihatPengajuanRoute = "/transaksi";
  static const fiturLihatPengajuanIndex = 2;

  static const fiturInputDataPengajuanRoute = "$fiturLihatPengajuanRoute/input";
  static const fiturInputListBarangRoute = "$fiturInputDataPengajuanRoute/listBarang";
}