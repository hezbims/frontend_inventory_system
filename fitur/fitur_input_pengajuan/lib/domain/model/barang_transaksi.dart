
class BarangTransaksi {
  final int? id;
  final int idBarang;
  final String namaBarang;
  final int quantity;
  final String? keterangan;
  BarangTransaksi({
    required this.id,
    required this.idBarang,
    required this.namaBarang,
    required this.quantity,
    required this.keterangan,
  });
}