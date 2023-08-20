
class Rak {
  final int nomorRak;
  final int nomorLaci;
  final int nomorKolom;
  Rak({
    required this.nomorRak,
    required this.nomorLaci,
    required this.nomorKolom,
  });

  static const _kolomNomorRak = 'nomor_rak';
  static const _kolomNomorLaci = 'nomor_laci';
  static const _kolomNomorKolom = 'nomor_kolom';

  factory Rak.fromjson(Map<String , dynamic> json){
    return Rak(
      nomorRak: json[_kolomNomorRak],
      nomorLaci: json[_kolomNomorLaci],
      nomorKolom: json[_kolomNomorKolom],
    );
  }

  Map<String , int> toJson(){
    return {
      _kolomNomorRak : nomorRak,
      _kolomNomorLaci : nomorLaci,
      _kolomNomorKolom : nomorKolom,
    };
  }
}