import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_screen.dart';
import 'package:flutter/material.dart';

class LihatStockBarangPage extends Page {

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) => const LihatStockBarangScreen()
    );
  }
}