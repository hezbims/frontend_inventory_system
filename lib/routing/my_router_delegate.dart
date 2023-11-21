import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_auth_guard/presentation/page/login_page.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_page.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/routing/splash_page.dart';

class MyRouterDelegate extends RouterDelegate<Object> with
    ChangeNotifier,
    PopNavigatorRouterDelegateMixin<Object>{

  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<MyRouteStateProvider>(
      builder: (context , provider , child){
        final pages = _buildPages(provider);
        return Navigator(
          key: _navigatorKey,
          pages: pages,
          onPopPage: (route , result){
            if (!route.didPop(result)) return false;
            return true;
          },
        );
      }
    );
  }

  List<Page<dynamic>> _buildPages(MyRouteStateProvider provider){
    var result = <Page<dynamic>>[];
    final state = provider.currentState;
    final currentUser = provider.currentUser;

    if (currentUser is UserFetchSuccess) {
      if (state is RouteLihatPengajuanState){
        result.add(const LihatPengajuanPage());
      } else if (state is RouteLoginState) {
        result.add(const LihatStockBarangPage());
      } else if (state is RouteLihatStockBarangState) {
        result.add(const LihatStockBarangPage());
      } else if (state is RouteSettingAkunState) {
        result.add(const SettingAkunPage());
      } else if (state is RoutePilihTahunBulanLaporanState) {
        result.add(const PilihBulanTahunPage());
      }
    }
    else if (currentUser is UserFetchLoading) {
      result.add(const SplashPage());
    } else if (currentUser is UserFetchFailed) {
      result.add(const LoginPage());
    }
    return result;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}


}