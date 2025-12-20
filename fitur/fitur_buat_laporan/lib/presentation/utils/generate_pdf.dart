import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/presentation/service/monthly_report_pdf_generator.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';


@Deprecated("gunakan service MonthlyReportPdfGenerator")
Future<Uint8List> generatePdf({
  required PdfPageFormat pageFormat,
  required String period,
  required ApiResponse apiResponse,
}) async {
  if (apiResponse is ApiResponseSuccess<List<DataLaporan>>) {
    final listDataLaporan = apiResponse.data!;
    return await MonthlyReportPdfGenerator().generatePdf(data: listDataLaporan,
        mainHeaderText: "MACHINE SPARE PART STOCK TAKING LIST\n"
        "BUSINESS UNIT : FAN\n"
        "PERIOD : $period");
  }
  else if (apiResponse is ApiResponseFailed){
    throw Exception(apiResponse.error.toString());
  }
  else {
    throw Exception("Enggak Mungkin T_T");
  }
}