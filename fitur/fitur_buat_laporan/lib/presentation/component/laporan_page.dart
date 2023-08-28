import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_table.dart';
import 'package:pdf/widgets.dart';


class LaporanPage extends StatelessWidget {
  final List<DataLaporan> listDataLaporan;
  LaporanPage({required this.listDataLaporan});

  @override
  Widget build(Context context) {
    return ListView(
        children: [
          LaporanTable(listDataLaporan: listDataLaporan)
        ]
    );
    // return Column(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       LaporanTitleHeader(),
    //
    //       SizedBox(height: 10),
    //
    //       LaporanTable(listDataLaporan : listDataLaporan),
    //     ]
    // );
  }

}
// Widget buildLaporanAllContent({required List<DataLaporan> listDataLaporan}){
//   return Column(
//     mainAxisSize: MainAxisSize.max,
//     children: [
//       LaporanHeader(),
//
//       ...listDataLaporan.map(
//         (dataLaporan) => buildLaporanKategoriSection(data: dataLaporan)
//       ),
//     ]
//   );
// }
