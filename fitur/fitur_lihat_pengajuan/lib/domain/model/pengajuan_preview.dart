import 'package:common/constant/enums/status_pengajuan.dart';

class PengajuanPreview {
  // sementara id-nya integer
  final int id;
  final String namaPengaju;
  final bool isPemasok;
  final String kodeTransaksi;
  final String username;
  final StatusPengajuan status;

  String get tipe {
    if (isPemasok) {
      return "Pemasukan";
    }
    return "Pengeluaran";
  }

  PengajuanPreview({
    required this.id,
    required this.namaPengaju,
    required this.isPemasok,
    required this.kodeTransaksi,
    required this.username,
    required this.status,
  });
}