import 'package:fitur_input_barang_by_csv/presentation/screen/input_barang_by_csv_screen.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvPage extends Page {
  const InputBarangByCsvPage() : super(
    key : const ValueKey('Input Barang By CSV Page')
  );

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const InputBarangByCsvScreen(),
    );
  }
}