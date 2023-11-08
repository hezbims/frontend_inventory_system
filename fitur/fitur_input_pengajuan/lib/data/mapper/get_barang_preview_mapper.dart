import 'package:common/domain/model/barang.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';

class GetBarangPreviewMapper {
  List<BarangPreview> fromListBarangToListBarangPreview(
    List<Barang> listBarang
  ){
    return listBarang.map((barang) =>
      BarangPreview(
        id: barang.id,
        kodeBarang: barang.kodeBarang,
        nama: barang.nama,
        currentStock: barang.stockSekarang,
        kategori: barang.kategori.nama,
        rak: 'R${barang.nomorRak}-${barang.nomorLaci}-${barang.nomorKolom}',
      ),
    ).toList();
  }
}