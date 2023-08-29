import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_barang_summary_row.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_table_header.dart';
import 'package:pdf/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class LaporanTable extends StatelessWidget {
  final List<DataLaporan> listDataLaporan;
  LaporanTable({required this.listDataLaporan});

  @override
  Widget build(Context context) {
    List<TransaksiBarangSummary> allBarangSummary = [
      for (int i = 0 ; i < listDataLaporan.length ; i++)
        ...listDataLaporan[i].barang,
    ];

    return Table(
      border: TableBorder.all(width: 0.5),
      columnWidths: {
        5 : const FixedColumnWidth(20),
        6 : const FixedColumnWidth(30),
        7 : const FixedColumnWidth(60),
        8 : const FixedColumnWidth(35),
        9 : const FixedColumnWidth(45),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        LaporanTableHeader(),

        ...allBarangSummary.mapIndexed(
          (index , data) => LaporanBarangSummaryRow(index: index , data: data),
        ),
      ],
    );
  }


}
