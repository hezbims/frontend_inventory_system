import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_auth_guard/presentation/page/login_page.dart';
import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_page.dart';
import 'package:fitur_input_form_data_barang/presentation/page/detail_barang_loader_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/detail_pengajuan_loader_page.dart';
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

            final state = provider.currentState;
            if (state is RouteInputPengajuanState){
              provider.setRouteState(
                RouteLihatPengajuanState(),
                notifyListener: false
              );
            }
            return true;
          },
        );
      }
    );
  }

  List<Page<dynamic>> _buildPages(MyRouteStateProvider provider){
    var listPages = <Page<dynamic>>[];
    final state = provider.currentState;
    final currentUser = provider.currentUser;

    if (currentUser is UserFetchSuccess) {

      // DEPTH == 1
      if (state is RouteLihatPengajuanState){
        listPages.add(const LihatPengajuanPage());
      } else if (state is RouteLihatStockBarangState) {
        listPages.add(const LihatStockBarangPage());
      } else if (state is RouteSettingAkunState) {
        listPages.add(const SettingAkunPage());
      } else if (state is RoutePilihTahunBulanLaporanState) {
        listPages.add(const PilihBulanTahunPage());
      }
      
      // DEPTH == 2
      if (state is RouteInputPengajuanState){
        listPages.add(DetailPengajuanLoaderPage(idPengajuan: state.idPengajuan));
      } else if (state is RouteInputFormDataBarangState) {
        listPages.add(DetailBarangLoaderPage(idBarang: state.idBarang));
      }
    }
    else if (currentUser is UserFetchLoading) {
      listPages.add(const SplashPage());
    } else if (currentUser is UserFetchFailed) {
      listPages.add(const LoginPage());
    }
    return listPages;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}


}