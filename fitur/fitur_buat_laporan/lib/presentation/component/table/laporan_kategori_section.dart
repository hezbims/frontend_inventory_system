import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_list_barang_summary.dart';
import 'package:pdf/widgets.dart';

Widget buildLaporanKategoriSection({required DataLaporan data}){
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Kategori : ${data.namaKategori}" , style: TextStyle(fontWeight: FontWeight.bold)),
      buildLaporanListBarangSummary(data: data.barang),
    ]
  );
}
