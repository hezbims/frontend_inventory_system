import 'package:common/constant/routes/routes_name.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_setting_akun/dependency_setup/setting_akun_page_dependency_setup.dart';
import 'package:flutter/material.dart';

final Map<String , dynamic Function(RouteSettings)> routeDepth1 = {
  RoutesName.lihatStockBarangName : (settings) => const LihatStockBarangPage(),
  RoutesName.buatLaporanName : (settings) => const PilihTahunBulanPage(),
  RoutesName.lihatPengajuanName : (settings) => const LihatPengajuanPage(),
  RoutesName.settingAkunName : (settings) => SettingAkunPageDependencySetup(),
  RoutesName.loginName : (settings) => const LoginScreen(),
};