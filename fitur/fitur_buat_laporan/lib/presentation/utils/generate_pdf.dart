import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/component/table/laporan_table.dart';
import 'package:fitur_buat_laporan/presentation/component/title/laporan_title_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> generatePdf({
  required PdfPageFormat pageFormat,
  required String period,
  required ApiResponse apiResponse,
}) async {
  if (apiResponse is ApiResponseSuccess<List<DataLaporan>>) {
    final listDataLaporan = apiResponse.data!;
    var pdfTheme = ThemeData.withFont(
      base: Font.ttf(await rootBundle.load("assets/google_fonts/Inter/static/Inter-Regular.ttf")),
      bold: Font.ttf(await rootBundle.load("assets/google_fonts/Inter/static/Inter-Bold.ttf")),
      italic: Font.ttf(await rootBundle.load("assets/google_fonts/Inter/static/Inter-Regular.ttf")),
      boldItalic: Font.ttf(await rootBundle.load("assets/google_fonts/Inter/static/Inter-Bold.ttf")),
    );

    final pdf = Document(theme: pdfTheme);

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