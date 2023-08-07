import 'package:common/presentation/bottom_navbar/stock_bottom_navbar_controller.dart';
import 'package:dependencies/get.dart';
import 'package:flutter/material.dart';

class StockBottomNavBar extends BottomNavigationBar {
  final _controller = Get.find<StockBottomNavBarController>();
  StockBottomNavBar({
    super.key,

  }) : super(
    items: [
      const BottomNavigationBarItem(
        icon: Icon(Icons.inventory),
        label: "Stock Barang"
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Laporan"
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.swap_vert),
        label: "Transaksi"
      ),
    ]
  );
}
