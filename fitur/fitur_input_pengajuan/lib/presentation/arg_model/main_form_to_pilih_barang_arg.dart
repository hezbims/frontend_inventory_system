import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';

class MainFormToPilihBarangArg {
  final List<BarangTransaksi> initialList;
  final bool isPemasukan;
  MainFormToPilihBarangArg({
    required this.initialList,
    required this.isPemasukan,
  });
}