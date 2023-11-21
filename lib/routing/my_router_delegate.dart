import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_auth_guard/presentation/page/login_page.dart';
import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_page.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_page.dart';
import 'package:flutter/material.dart';
import 'package:inventory_system/routing/splash_page.dart';

class MyRouterDelegate extends RouterDelegate<Object> with
    ChangeNotifier,
    PopNavigatorRouterDelegateMixin<Object>{

  MyRouterDelegate();

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
    debugPrint('State type : ${state.runtimeType}');
    if (state.getUserResponse is UserFetchLoading) {
      result.add(const SplashPage());
    } else if (state.getUserResponse is UserFetchFailed) {
      result.add(const LoginPage());
    } else if (state.getUserResponse is UserFetchSuccess) {
      if (state is RouteLoginState) {
        result.add(const LihatStockBarangPage());
      } else if (state is RouteLihatStockBarangState) {
        result.add(const LihatStockBarangPage());
      } else if (state is RouteSettingAkunState) {
        result.add(SettingAkunPage());
      }

    }
    return result;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}


}