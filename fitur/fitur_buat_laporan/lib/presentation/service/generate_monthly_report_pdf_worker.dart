import 'dart:typed_data';

import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:isolate_manager/isolate_manager.dart';
import 'package:pdf/widgets.dart';

import '../../domain/model/data_laporan.dart';
import '../component/table/laporan_table.dart';
import '../component/title/laporan_title_header.dart';

@pragma('vm:entry-point')
@isolateManagerWorker
Future<Uint8List> generateMonthlyReportPdfWorker(
  ImMap unparsedArgs,
) async {
  final PdfWorkerArgs args = PdfWorkerArgs.fromImMap(unparsedArgs);
  final pdfTheme = ThemeData.withFont(
    base: Font.ttf(args.fontRegular),
    bold: Font.ttf(args.fontBold),
    italic: Font.ttf(args.fontRegular),
    boldItalic: Font.ttf(args.fontBold),
  );

  final pdf = Document(theme: pdfTheme);

  pdf.addPage(
      MultiPage(
          build: (context){
            return [
              LaporanTitleHeader(mainHeaderText: args.mainHeaderText),

              SizedBox(height: 10),

              LaporanTable(listDataLaporan: args.data)
            ];
          }
      )
  );

  return await pdf.save();
}

class PdfWorkerArgs {
  final List<DataLaporan> data;
  final String mainHeaderText;
  final ByteData fontRegular;
  final ByteData fontBold;

  PdfWorkerArgs({
    required this.data,
    required this.mainHeaderText,
    required this.fontRegular,
    required this.fontBold,
  });

  static PdfWorkerArgs fromImMap(ImMap imMap){
    final Map<Object, Object> json = imMap.unwrap;
    
    final fontRegularList = (json['fontRegular'] as Iterable).cast<int>().toList();
    final fontBoldList = (json['fontBold'] as Iterable).cast<int>().toList();
    final data = (json['data'] as Iterable).map((e) {
      final dataPerCategoryAsJson = e as Map<Object, Object>;

      return _dataLaporanFromImMap(dataPerCategoryAsJson);
    }).toList();

    return PdfWorkerArgs(
      data: data,
      mainHeaderText: json['mainHeaderText'] as String,
      fontRegular: ByteData.sublistView(Uint8List.fromList(fontRegularList)),
      fontBold: ByteData.sublistView(Uint8List.fromList(fontBoldList)),
    );
  }

  ImMap toImMap(){
    final Map<Object, Object> json = {};

    json['mainHeaderText'] = mainHeaderText;
    json['fontRegular'] = ImList.wrap(fontRegular.buffer.asUint8List());
    json['fontBold'] = ImList.wrap(fontBold.buffer.asUint8List());
    json['data'] = ImList.wrap(data.map((e) => e.toImMap()));

    return ImMap.wrap(json);
  }
}

extension _DataLaporanImMapExtension on DataLaporan {
  ImMap toImMap(){
    return ImMap.wrap({
      'namaKategori': namaKategori,
      'barang': ImList.wrap(barang.map((e) => e.toImMap())),
    });
  }
}

extension _TransaksiBarangSummaryImMapExtension on TransaksiBarangSummary {
  ImMap toImMap(){
    return ImMap.wrap({
      'kodeBarang': kodeBarang,
      'nomorRak': nomorRak,
      'nomorLaci': nomorLaci,
      'nomorKolom': nomorKolom,
      'namaBarang': namaBarang,
      'uom': uom,
      'minStock': minStock,
      'lastMonthStock': lastMonthStock,
      'currentStock': currentStock,
      'totalMasuk': totalMasuk,
      'totalKeluar': totalKeluar,
      'unitPrice': unitPrice,
      'amount': amount,
    });
  }
}


DataLaporan _dataLaporanFromImMap(Map<Object, Object> imMap){
  return DataLaporan(
    namaKategori: imMap['namaKategori'] as String,
    barang: (imMap['barang'] as Iterable).map((e){
      final transaksiBarangImMap = e as Map<Object, Object>;

      return _transaksiBarangSummaryFromImMap(transaksiBarangImMap);
    }).toList(),
  );
}

TransaksiBarangSummary _transaksiBarangSummaryFromImMap(Map<Object, Object> imMap){
  return TransaksiBarangSummary(
    kodeBarang: imMap['kodeBarang'] as String,
    nomorRak: imMap['nomorRak'] as int,
    nomorLaci: imMap['nomorLaci'] as int,
    nomorKolom: imMap['nomorKolom'] as int,
    namaBarang: imMap['namaBarang'] as String,
    uom: imMap['uom'] as String,
    minStock: imMap['minStock'] as int,
    lastMonthStock: imMap['lastMonthStock'] as int,
    currentStock: imMap['currentStock'] as int,
    totalMasuk: imMap['totalMasuk'] as int,
    totalKeluar: imMap['totalKeluar'] as int,
    unitPrice: imMap['unitPrice'] as int,
    amount: imMap['amount'] as int,
  );
}