import 'package:common/constant/query_param/key/query_params_key_buat_laporan.dart';
import 'package:common/constant/routes/routes_name.dart';

abstract class RoutesPath {
  static const initialRoute = '/';

  static const lihatStockBarangPath = "/${RoutesName.lihatStockBarangName}";
  static const lihatStockBarangIndex = 0;

  static String inputDataBarangPath(Object idBarang) =>
    "$lihatStockBarangPath/$idBarang";

  static const lihatPengajuanPath = "/${RoutesName.lihatPengajuanName}";
  static const fiturLihatPengajuanIndex = 2;

  static String inputDataPengajuanPath({required Object idPengajuan}){
    return "$lihatPengajuanPath/$idPengajuan";
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