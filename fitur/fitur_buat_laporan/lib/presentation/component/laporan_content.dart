import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/laporan_kategori_section.dart';
import 'package:pdf/widgets.dart';


Widget buildLaporanAllContent({required List<DataLaporan> listDataLaporan}){
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      ...listDataLaporan.map(
        (dataLaporan) => buildLaporanKategoriSection(data: dataLaporan)
      ),
    ]
  );
}
