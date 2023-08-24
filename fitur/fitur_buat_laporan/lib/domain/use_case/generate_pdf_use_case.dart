import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/laporan_content.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
class GeneratePdfUseCase {
  Future<Uint8List> generate({
    required PdfPageFormat pageFormat,
    required List<DataLaporan> listDataLaporan,
  }){
    final pdf = Document();
    
    pdf.addPage(
      Page(
        pageFormat: pageFormat,
        build: (context){
          return buildLaporanAllContent(listDataLaporan: listDataLaporan);
        }
      )
    );

    return pdf.save();
  }
}