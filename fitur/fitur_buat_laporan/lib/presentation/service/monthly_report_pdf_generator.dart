import 'package:fitur_buat_laporan/domain/service/i_monthly_report_pdf_generator.dart';
import 'package:flutter/services.dart';
import 'package:isolate_manager/isolate_manager.dart';

import '../../domain/model/data_laporan.dart';
import 'generate_monthly_report_pdf_worker.dart';

class MonthlyReportPdfGenerator implements IMonthlyReportPdfGenerator {

  static final interRegularFont = rootBundle.load("assets/google_fonts/Inter/static/Inter-Regular.ttf");
  static final interBoldFont = rootBundle.load("assets/google_fonts/Inter/static/Inter-Bold.ttf");

  @override
  Future<Uint8List> generatePdf({
    required List<DataLaporan> data,
    required String mainHeaderText
  }) async {
    final workerArgs = PdfWorkerArgs(
      data: data,
      mainHeaderText: mainHeaderText,
      fontRegular: await interRegularFont,
      fontBold: await interBoldFont,
    );

    final Uint8List result;
    try {
      result = await IsolateManager.run(
        () => generateMonthlyReportPdfWorker(workerArgs.toImMap()),
        workerName: 'generateMonthlyReportPdfWorker',
        workerParameter: workerArgs.toImMap(),
      );

    } catch (e) {
      // TODO : Log something to crash analytics
      rethrow;
    }

    return result;
  }
}