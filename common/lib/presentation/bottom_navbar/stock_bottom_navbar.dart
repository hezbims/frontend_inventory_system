import 'package:common/constant/routes/routes_path.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';

class StockBottomNavBar extends StatelessWidget {
  final int _currentIndex;
  const StockBottomNavBar({
    required int currentIndex,
    super.key,
  }) : _currentIndex = currentIndex;

  @override
  Widget build(BuildContext context) {
    final MyRouteStateProvider routeStateProvider = context.read();
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index){
        if (index == _currentIndex){
          return;
        }
        switch (index){
          case RoutesPath.lihatStockBarangIndex:
            routeStateProvider.setRouteState(RouteLihatStockBarangState());
            break;
          case RoutesPath.fiturLihatPengajuanIndex:
            routeStateProvider.setRouteState(RouteLihatPengajuanState());
            break;
          case RoutesPath.buatLaporanIndex:
            routeStateProvider.setRouteState(RoutePilihTahunBulanLaporanState());
            break;
          case RoutesPath.settingAkunIndex:
            routeStateProvider.setRouteState(RouteSettingAkunState());
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Stock Barang"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Laporan"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.swap_vert),
            label: "Transaksi"
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Akun',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
