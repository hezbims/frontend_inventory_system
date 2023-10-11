import 'package:common/constant/routes/routes_name.dart';
import 'package:fitur_buat_laporan/presentation/page/preview_laporan_page.dart';
import 'package:fitur_input_data_barang/dependency_setup/input_data_barang_dependency_setup.dart';
import 'package:fitur_input_pengajuan/dependency_setup/input_data_pengajuan_page_setup.dart';
import 'package:flutter/material.dart';

final Map<String , dynamic Function(RouteSettings)> routeDepth2 = {
  RoutesName.inputDataBarangName : (settings) {
    if (settings.arguments == null){
      return RoutesName.lihatStockBarangName;
    }
    return InputDataBarangDependencySetup(settings: settings);
  },
  RoutesName.previewPdfName : (settings) => const PreviewLaporanPage(),
  RoutesName.inputDataPengajuanName : (settings) =>
      InputDataPengajuanPageSetup(),
};