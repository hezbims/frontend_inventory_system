import 'package:common/utils/currency_formatter.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/presentation/style/text_style.dart';
import 'package:pdf/widgets.dart';

class LaporanBarangSummaryRow extends TableRow{
  final TransaksiBarangSummary data;
  final int index;
  LaporanBarangSummaryRow({
    required this.data,
    required this.index,
  }) : super(
    children: [
      Text(index.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Text("R${data.nomorRak}-${data.nomorLaci}" , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Text(data.namaBarang , style: textNormalStyle , maxLines: 1),
      Text("Rack ${data.nomorRak}" , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Text(data.uom , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Text(data.minStock.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Text(data.lastMonthStock.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
      Table(
        border: TableBorder.all(width: 0.5),
        columnWidths: {
          0 : const FlexColumnWidth(1),
          1 : const FlexColumnWidth(1),
          2 : const FlexColumnWidth(2),
        },
        children: [
          TableRow(
            children: [
              Text(data.totalMasuk.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
              Text(data.totalKeluar.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
              Text(data.lastMonthStock.toString() , style: textNormalStyle , textAlign: TextAlign.center , maxLines: 1),
            ],
          )
        ]
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3 , right: 2),
        child: Row(
            children: [
              Text("Rp" , style: textNormalStyle),
              Expanded(child: Text(CurrencyFormatter.toRupiah(data.unitPrice) , style: textNormalStyle , textAlign: TextAlign.right , maxLines: 1))
            ]
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3 , right: 2),
        child: Row(
          children: [
            Text("Rp" , style: textNormalStyle),
            Expanded(child: Text(CurrencyFormatter.toRupiah(data.unitPrice * data.lastMonthStock) , style: textNormalStyle , textAlign: TextAlign.right , maxLines: 1))
          ]
        ),
      )
    ]
  );
}
// Widget buildLaporanBarangSummaryRow (TransaksiBarangSummary data){
//   return Row(
//     children: [
//       Expanded(child: Text(data.namaBarang)),
//       Expanded(child: Text("R${data.nomorRak}-${data.nomorLaci}-${data.nomorKolom}")),
//       Expanded(child: Text(data.uom)),
//       Expanded(child: Text(data.minStock.toString())),
//       Expanded(child: Text(data.lastMonthStock.toString())),
//       Expanded(child: Text(data.totalMasuk.toString())),
//       Expanded(child: Text(data.totalKeluar.toString())),
//       Expanded(child: Text(data.unitPrice.toString())),
//
//     ]
//   );
// }