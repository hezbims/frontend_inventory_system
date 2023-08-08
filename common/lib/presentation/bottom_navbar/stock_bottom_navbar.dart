import 'package:common/presentation/bottom_navbar/stock_bottom_navbar_controller.dart';
import 'package:common/routes/routes.dart';
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
    final StockBottomNavBarProvider provider = Provider.of(context , listen: false);
    return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          String? nextRoute;
          switch (index){
            case Routes.fiturLihatStockBarangIndex:
              nextRoute = Routes.fiturLihatStockBarangRoute;
              break;
            case Routes.fiturLihatPengajuanIndex:
              nextRoute = Routes.fiturLihatPengajuanRoute;
              break;
          }

          if (nextRoute != null){
            Navigator.of(context).pushReplacementNamed(nextRoute);
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
        ]
    );
  }
}
