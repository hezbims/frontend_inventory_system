import 'package:common/constant/routes/routes_name.dart';

abstract class RoutesPath {
  static const initialRoute = '/';

  static const lihatStockBarangPath = "/${RoutesName.lihatStockBarangName}";
  static const lihatStockBarangIndex = 0;

  static const inputDataBarangPath = "$lihatStockBarangPath/${RoutesName.inputDataBarangName}";
  static const pilihKategoriPath = "$inputDataBarangPath/${RoutesName.pilihKategoriName}";

  static const lihatPengajuanPath = "/${RoutesName.lihatPengajuanName}";
  static const fiturLihatPengajuanIndex = 2;

  static const inputDataPengajuanPath = "$lihatPengajuanPath/${RoutesName.inputDataPengajuanName}";
  static const inputListBarangPath = "$inputDataPengajuanPath/${RoutesName.inputListBarangName}";
  static const pilihPengajuPath = "$lihatPengajuanPath/${RoutesName.pilihPengajuName}";

  static const buatLaporanPath = "/${RoutesName.buatLaporanName}";
  static const previewPdfPath = "$buatLaporanPath/${RoutesName.previewPdfName}";
  static const buatLaporanIndex = 1;

  static const loginPath = '/${RoutesName.loginName}';

  static const settingAkunPath = '/${RoutesName.settingAkunName}';
  static const settingAkunIndex = 3;
}