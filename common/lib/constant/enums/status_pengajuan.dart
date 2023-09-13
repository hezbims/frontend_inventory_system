enum StatusPengajuan {
  menunggu,
  diterima,
  ditolak;

  factory StatusPengajuan.from(String str){
    switch (str){
      case 'menunggu':
        return menunggu;
      case 'diterima':
        return diterima;
      case 'ditolak':
        return ditolak;
      default:
        throw FormatException("Value $str tidak ditemukan dalam enum status pengajuan");
    }
  }
}