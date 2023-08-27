import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:pdf/widgets.dart';

Widget buildLaporanBarangSummaryRow (TransaksiBarangSummary data){
  return Row(
    children: [
      Expanded(child: Text(data.namaBarang)),
      Expanded(child: Text("R${data.nomorRak}-${data.nomorLaci}-${data.nomorKolom}")),
      Expanded(child: Text(data.uom)),
      Expanded(child: Text(data.minStock.toString())),
      Expanded(child: Text(data.lastMonthStock.toString())),
      Expanded(child: Text(data.totalMasuk.toString())),
      Expanded(child: Text(data.totalKeluar.toString())),
      Expanded(child: Text(data.unitPrice.toString())),

    ]
  );
}