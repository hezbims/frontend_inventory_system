
class Kategori {
  final int id;
  final String nama;
  Kategori({
    required this.id,
    required this.nama,
  });

  static const _kolomId = 'id';
  static const _kolomNama = 'nama';
  factory Kategori.fromJson(Map<String , dynamic> json){
    return Kategori(
      id: json[_kolomId],
      nama: json[_kolomNama]
    );
  }

  Map<String , dynamic> toJson(){
    return {
      _kolomId : id,
      _kolomNama : nama,
    };
  }

  @override
  String toString(){
    return nama;
  }
}