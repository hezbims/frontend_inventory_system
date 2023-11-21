import 'package:fitur_lihat_stock_barang/presentation/page/lihat_stock_barang_screen.dart';
import 'package:flutter/material.dart';

class LihatStockBarangPage extends Page {

  const LihatStockBarangPage() : super(
    key: const ValueKey('Lihat Stock Barang Page')
  );

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const LihatStockBarangScreen()
    );
  }
}