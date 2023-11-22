import 'package:fitur_buat_laporan/presentation/page/preview_laporan_screen.dart';
import 'package:flutter/material.dart';

class PreviewLaporanPage extends Page {
  final int tahun;
  final int bulan;
  const PreviewLaporanPage({
    required this.tahun, required this.bulan
  }) : super(key: const ValueKey('Preview Laporan Page'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => PreviewLaporanScreen(tahun: tahun, bulan: bulan)
    );
  }
}