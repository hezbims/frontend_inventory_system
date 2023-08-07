import 'package:common/presentation/bottom_navbar/stock_bottom_navbar_controller.dart';
import 'package:dependencies/provider.dart';
import 'package:flutter/material.dart';

class StockBottomNavBar extends StatelessWidget {
  const StockBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final StockBottomNavBarProvider provider = Provider.of(context , listen: false);
    return BottomNavigationBar(
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
