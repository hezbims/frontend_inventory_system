import 'package:flutter/material.dart';

class TransaksiFilterProvider extends ChangeNotifier {
  String? _tipeTransaksi;
  String? get tipeTransaksi => _tipeTransaksi;
  void onChangeTipeTransaksi(String? value) {
    _tipeTransaksi = value;
  }

  
}