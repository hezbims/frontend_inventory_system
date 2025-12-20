import 'package:fitur_buat_laporan/domain/service/i_monthly_report_pdf_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

import '../../domain/model/data_laporan.dart';
import '../component/table/laporan_table.dart';
import '../component/title/laporan_title_header.dart';

class MonthlyReportPdfGenerator implements IMonthlyReportPdfGenerator {

  static final interRegularFont = rootBundle.load("assets/google_fonts/Inter/static/Inter-Regular.ttf");
  static final interBoldFont = rootBundle.load("assets/google_fonts/Inter/static/Inter-Bold.ttf");

  @override
  Future<Uint8List> generatePdf({
    required List<DataLaporan> data,
    required String mainHeaderText
  }) async {
    final workerArgs = _PdfWorkerArgs(
      data: data,
      mainHeaderText: mainHeaderText,
      fontRegular: await interRegularFont,
      fontBold: await interBoldFont,
    );

    return compute(_generatePdfWorker, workerArgs);
  }
}

class _PdfWorkerArgs {
  final List<DataLaporan> data;
  final String mainHeaderText;
  final ByteData fontRegular;
  final ByteData fontBold;

  _PdfWorkerArgs({
    required this.data,
    required this.mainHeaderText,
    required this.fontRegular,
    required this.fontBold,
  });
}

Future<Uint8List> _generatePdfWorker(_PdfWorkerArgs args) async {
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
