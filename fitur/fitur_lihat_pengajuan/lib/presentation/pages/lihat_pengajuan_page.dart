import 'package:fitur_lihat_pengajuan/presentation/pages/lihat_pengajuan_screen.dart';
import 'package:flutter/material.dart';

class LihatPengajuanPage extends Page {
  const LihatPengajuanPage() : super(key: const ValueKey('Lihat Pengajuan Page'));
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const LihatPengajuanScreen()
    );
  }
}