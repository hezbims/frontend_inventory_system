import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/constant/routes/routes.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_pengajuan/page_setup/input_data_pengajuan_page_setup.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_list_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_pengaju_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:common/presentation/page_setup/page_setup.dart';

final routesMap = {
  Routes.initialRoute : PageSetup(
      setup: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturLihatStockBarangRoute : PageSetup(
      setup: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturInputDataBarangRoute : PageSetup(
      setup: (){},
      page: const InputDataBarangPage()
  ),
  Routes.fiturPilihKategoriRoute : PageSetup(
      setup: (){},
      page: const PilihKategoriPage()
  ),
  Routes.fiturLihatPengajuanRoute : PageSetup(
      setup: (){},
      page: const LihatPengajuanPages()
  ),
  Routes.fiturInputDataPengajuanRoute : InputDataPengajuanPageSetup(),
  Routes.fiturInputListBarangRoute : PageSetup(
      setup: (){},
      page: const PilihListBarangPage()
  ),
  Routes.fiturPilihGroupRoute : PageSetup(
      setup: (){},
      page: const PilihPengajuPage()
  ),
  Routes.fiturBuatLaporanRoute : PageSetup(
      setup: (){},
      page: const PilihTahunBulanPage()
  ),
  Routes.previewLaporanRoute : PageSetup(
      setup: (){},
      page: const PreviewLaporanPage()
  ),
  Routes.settingAkunRoute : PageSetup(
      setup: (){},
      page: const SettingAkunPage()
  ),
  Routes.loginRoute : PageSetup(
      setup: (){},
      page: const LoginScreen()
  ),
};