import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_table.dart';
import 'package:fitur_buat_laporan/presentation/component/title/laporan_title_header.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
class GeneratePdfUseCase {
  Future<Uint8List> generate({
    required PdfPageFormat pageFormat,
    required String period,
    required List<DataLaporan> listDataLaporan,
  }) async {
    final pdf = Document();
    
    pdf.addPage(
      MultiPage(
        build: (context){
          return [
            LaporanTitleHeader(period: period),

            SizedBox(height: 10),

            LaporanTable(listDataLaporan: listDataLaporan)
          ];
        }
      )
    );

    return pdf.save();
  }
}