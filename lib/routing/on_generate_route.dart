import 'package:common/constant/routes/routes_name.dart';
import 'package:common/constant/routes/routes_path.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:fitur_auth_guard/presentation/route_guard.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_pages.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_setting_akun/dependency_setup/setting_akun_page_dependency_setup.dart';
import 'package:flutter/material.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings){
  final urlPathSegments = Uri.parse(settings.name!).pathSegments;
  final pathLength = urlPathSegments.length;

  debugPrint('Route name : ${settings.name}, segment : $urlPathSegments');

  late Widget nextPage;
  String nextUrl = settings.name!;
  bool needRouteGuard = true;

  // kalau path-nya ada di root, redirect ke lihat stock barang
  if (pathLength == 0){
    nextUrl = RoutesPath.lihatStockBarangPath;
    nextPage = const LihatStockBarangPage();
  }
  else if (pathLength == 1){
    switch (urlPathSegments.last) {
      case RoutesName.loginName:
        nextPage = const LoginScreen();
        needRouteGuard = false;
        break;
      case RoutesName.lihatStockBarangName:
        nextPage = const LihatStockBarangPage();
        break;
      case RoutesName.buatLaporanName:
        nextPage = const PilihTahunBulanPage();
        break;
      case RoutesName.lihatPengajuanName:
        nextPage = const LihatPengajuanPage();
        break;
      case RoutesName.settingAkunName:
        nextPage = SettingAkunPageDependencySetup();
        break;
      default:
        throw Exception('Unknown route path : ${settings.name}');
    }
  }
  else if (pathLength == 2){

  }


  settings = RouteSettings(
    name: nextUrl,
    arguments: settings.arguments
  );
  if (needRouteGuard){
    nextPage = RouteGuard(displayedPage: nextPage);
  }

  return MaterialPageRoute(
    builder: (context) => nextPage,
    settings: settings,
  );
}