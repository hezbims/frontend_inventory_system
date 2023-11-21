import 'package:fitur_buat_laporan/presentation/page/pilih_bulan_tahun_screen.dart';
import 'package:flutter/material.dart';

class PilihBulanTahunPage extends Page {
  const PilihBulanTahunPage() : super(key: const ValueKey('Pilih Bulan Tahun Page'));
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const PilihBulanTahunScreen()
    );
  }
}