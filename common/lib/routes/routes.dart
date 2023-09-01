abstract class Routes {
  static const initialRoute = '/';

  static const fiturLihatStockBarangRoute = "/stock-barang";
  static const fiturLihatStockBarangIndex = 0;

  static const fiturInputDataBarangRoute = "$fiturLihatStockBarangRoute/input";
  static const fiturPilihKategoriRoute = "$fiturInputDataBarangRoute/kategori";

  static const fiturLihatPengajuanRoute = "/transaksi";
  static const fiturLihatPengajuanIndex = 2;

  static const fiturInputDataPengajuanRoute = "$fiturLihatPengajuanRoute/input";
  static const fiturInputListBarangRoute = "$fiturInputDataPengajuanRoute/listBarang";
  static const fiturPilihGroupRoute = "$fiturLihatPengajuanRoute/pilih-group";

  static const fiturBuatLaporanRoute = "/laporan";
  static const previewLaporanRoute = "$fiturBuatLaporanRoute/preview";
  static const fiturBuatLaporanIndex = 1;

  static const loginRoute = '/login';

  static const settingAkunRoute = '/setting-akun';
  static const settingAkunIndex = 3;
}