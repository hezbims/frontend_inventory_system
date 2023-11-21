import 'package:fitur_input_pengajuan/presentation/pages/detail_pengajuan_loader.dart';
import 'package:flutter/material.dart';

class DetailPengajuanLoaderPage extends Page {
  final int? idPengajuan;
  const DetailPengajuanLoaderPage({required this.idPengajuan}) : super(
    key: const ValueKey('Detail Pengajuan Loader')
  );

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => DetailPengajuanLoader(idPengajuan: idPengajuan)
    );
  }
}