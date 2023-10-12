import 'package:common/dependency_injection/common_di.dart';
import 'package:fitur_auth_guard/dependency_injection/fitur_auth_guard_di.dart';
import 'package:fitur_buat_laporan/dependency_injection/fitur_buat_laporan_di.dart';
import 'package:fitur_input_data_barang/dependency_injection/fitur_input_data_barang_di.dart';
import 'package:fitur_input_pengajuan/dependency_injection/fitur_input_pengajuan_di.dart';
import 'package:fitur_lihat_pengajuan/dependency_injection/fitur_lihat_pengajuan_dependency_injection.dart';
import 'package:fitur_lihat_stock_barang/dependency_injection/fitur_lihat_stock_barang_di.dart';

void setupMainDependencyInjection(){
  commonDi();

  fiturAuthGuardDi();
  fiturBuatLaporanDi();
  fiturInputDataBarangDI();
  fiturInputPengajuanDi();
  fiturLihatPengajuanDependencyInjection();
  fiturLihatStockBarangDi();
}