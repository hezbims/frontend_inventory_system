import 'package:common/constant/query_param/key/query_params_key_buat_laporan.dart';
import 'package:common/constant/routes/routes_name.dart';
import 'package:flutter/material.dart';

abstract class RoutesPath {
  static const initialRoute = '/';

  static const lihatStockBarangPath = "/${RoutesName.lihatStockBarangName}";
  static const lihatStockBarangIndex = 0;

  static const inputDataBarangPath = "$lihatStockBarangPath/${RoutesName.inputDataBarangName}";
  static const pilihKategoriPath = "$inputDataBarangPath/${RoutesName.pilihKategoriName}";

  static const lihatPengajuanPath = "/${RoutesName.lihatPengajuanName}";
  static const fiturLihatPengajuanIndex = 2;

  static String inputDataPengajuanPath({required int idPengajuan}){
    return "$lihatPengajuanPath/${RoutesName.inputDataPengajuanName}/$idPengajuan";
  }
  static String inputListBarangPath({
    required BuildContext context
  }) {
    final currentPath = ModalRoute.of(context)?.settings.name;
    return "$currentPath/${RoutesName.inputListBarangName}";
  }
  static String pilihPengajuPath({
    required BuildContext context,
  }){
    final currentPath = ModalRoute.of(context)?.settings.name;
    return "$currentPath/${RoutesName.pilihPengajuName}";
  }

  static const buatLaporanPath = "/${RoutesName.buatLaporanName}";
  static String previewPdfPath({
    required int bulan,
    required int tahun,
  }) {
    return "$buatLaporanPath/${RoutesName.previewPdfName}?"
        "${QueryParamKeys.bulan}=$bulan&"
        "${QueryParamKeys.tahun}=$tahun";
  }
  static const buatLaporanIndex = 1;

  static const loginPath = '/${RoutesName.loginName}';

  static const settingAkunPath = '/${RoutesName.settingAkunName}';
  static const settingAkunIndex = 3;

}