import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:fitur_buat_laporan/domain/use_case/generate_pdf_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';

class PreviewLaporanProvder extends ChangeNotifier{
  final _pdfGenerator = GeneratePdfUseCase();

  final IGetDataLaporanRepository _repository;
  final GeneratePdfParameterDto _param;
  PreviewLaporanProvder({
    required IGetDataLaporanRepository repository,
    required GeneratePdfParameterDto param,
  }) : _repository = repository , _param = param;

  Future<ApiResponse>? _dataLaporanResponse;
  Future<ApiResponse> get dataLaporanResponse {
    return _dataLaporanResponse ??= _repository.getDataLaporan(_param);
  }

  Future<Uint8List> generatePdf(PdfPageFormat pageFormat) async {
    final apiResponse = await _repository.getDataLaporan(_param);

    if (apiResponse is ApiResponseSuccess<List<DataLaporan>>) {
      return _pdfGenerator.generate(
        pageFormat: pageFormat,
        listDataLaporan: apiResponse.data!
      );
    }
    else if (apiResponse is ApiResponseFailed){
      throw Exception(apiResponse.error.toString());
    }
    else {
      throw Exception("Enggak Mungkin T_T");
    }
  }

  void refresh() => notifyListeners();
}