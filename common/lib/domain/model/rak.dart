class Rak {
  final int nomorRak;
  final int nomorLaci;
  final int nomorKolom;
  Rak({
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
  });

  factory Rak.fromjson(Map<String , dynamic> json){
    return Rak(
      nomorRak: json['nomor_rak'],
      nomorLaci: json['nomor_laci'],
      nomorKolom: json['nomor_kolom']
    );
  }
}