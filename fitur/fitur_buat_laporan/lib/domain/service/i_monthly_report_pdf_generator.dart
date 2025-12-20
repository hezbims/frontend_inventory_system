import 'dart:typed_data';

import '../model/data_laporan.dart';

abstract class IMonthlyReportPdfGenerator {
  Future<Uint8List> generatePdf({
    required List<DataLaporan> data,
    required String mainHeaderText,
  });
}