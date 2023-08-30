import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:flutter/foundation.dart';

class PreviewLaporanProvder extends ChangeNotifier{
  final IGetDataLaporanRepository _repository;
  final GeneratePdfParameterDto _param;
  PreviewLaporanProvder({
    required IGetDataLaporanRepository repository,
    required GeneratePdfParameterDto param,
  }) : _param = param, _repository = repository;

  Future<ApiResponse>? _dataLaporanResponse;
  Future<ApiResponse> get dataLaporanResponse {
    return _dataLaporanResponse ??= _repository.getDataLaporan(_param);
  }

  Future<ApiResponse> getDataLaporan() =>
    _repository.getDataLaporan(_param);

  void refresh() => notifyListeners();

  String get period => _param.period;
}