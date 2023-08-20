class PengajuanPreview {
  // sementara id-nya integer
  final int id;
  final String namaPengaju;
  final bool isPemasok;
  final DateTime tanggal;

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
    required this.tanggal,
  });
}