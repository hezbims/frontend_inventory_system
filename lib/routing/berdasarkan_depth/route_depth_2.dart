import 'package:common/constant/routes/routes_name.dart';
import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:fitur_input_data_barang/presentation/page/input_data_barang_page.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';
import 'package:flutter/material.dart';

final Map<String , dynamic Function(RouteSettings)> routeDepth2 = {
  RoutesName.inputDataBarangName : (settings) {
    if (settings.arguments == null){
      return RoutesName.lihatStockBarangName;
    }
    return const InputDataBarangPage(initialBarang: null);
  },
  RoutesName.previewPdfName : (settings) => const PreviewLaporanPage(bulan: 20,tahun: 2,),
  RoutesName.inputDataPengajuanName : (settings) =>
      const InitialDetailPengajuanLoader(idPengajuan: 0,),
};