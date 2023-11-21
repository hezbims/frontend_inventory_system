import 'package:fitur_input_form_data_barang/presentation/page/detail_barang_loader.dart';
import 'package:flutter/material.dart';

class DetailBarangLoaderPage extends Page {
  final int? idBarang;
  const DetailBarangLoaderPage({required this.idBarang}) : super(
    key: const ValueKey('Detail Barang Loader Page')
  );

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => DetailBarangLoader(idBarang: idBarang),
    );
  }
}