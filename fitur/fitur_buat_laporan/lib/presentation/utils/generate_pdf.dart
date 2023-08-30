import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_table.dart';
import 'package:fitur_buat_laporan/presentation/component/title/laporan_title_header.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> generatePdf({
  required PdfPageFormat pageFormat,
  required String period,
  required ApiResponse apiResponse,
}) {
  if (apiResponse is ApiResponseSuccess<List<DataLaporan>>) {
    final listDataLaporan = apiResponse.data!;

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
  else if (apiResponse is ApiResponseFailed){
    throw Exception(apiResponse.error.toString());
  }
  else {
    throw Exception("Enggak Mungkin T_T");
  }
}