import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/routes/routes.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_login/presentation/login_screen.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';

final routesMap = {
  Routes.initialRoute : const LihatStockBarangPage(),
  Routes.fiturLihatStockBarangRoute : const LihatStockBarangPage(),
  Routes.fiturInputDataBarangRoute : const InputDataBarangPage(),
  Routes.fiturPilihKategoriRoute : const PilihKategoriPage(),
  Routes.fiturLihatPengajuanRoute : const LihatPengajuanPages(),
  Routes.fiturInputDataPengajuanRoute : const InitialDetailPengajuanLoader(),
  Routes.fiturInputListBarangRoute : const PilihListBarangPage(),
  Routes.fiturPilihGroupRoute : const PilihPengajuPage(),
  Routes.fiturBuatLaporanRoute : const PilihTahunBulanPage(),
  Routes.previewLaporanRoute : const PreviewLaporanPage(),
  Routes.settingAkunRoute : const SettingAkunPage(),
  Routes.loginRoute : const LoginScreen(setCurrentSessionToken: setCurrentSessionToken);
};