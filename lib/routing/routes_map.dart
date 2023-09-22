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
import 'package:common/presentation/page_setup/get_it_page_setup.dart';

final routesMap = {
  Routes.initialRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturLihatStockBarangRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatStockBarangPage()
  ),
  Routes.fiturInputDataBarangRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const InputDataBarangPage()
  ),
  Routes.fiturPilihKategoriRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const PilihKategoriPage()
  ),
  Routes.fiturLihatPengajuanRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const LihatPengajuanPages()
  ),
  Routes.fiturInputDataPengajuanRoute : InputDataPengajuanPageSetup(),
  Routes.fiturInputListBarangRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const PilihListBarangPage()
  ),
  Routes.fiturPilihGroupRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const PilihPengajuPage()
  ),
  Routes.fiturBuatLaporanRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const PilihTahunBulanPage()
  ),
  Routes.previewLaporanRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const PreviewLaporanPage()
  ),
  Routes.settingAkunRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const SettingAkunPage()
  ),
  Routes.loginRoute : GetItPageSetup(
      setup: (){},
      disposeFunction: (){},
      page: const LoginScreen()
  ),
};