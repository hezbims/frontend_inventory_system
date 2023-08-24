import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/data/api_client/get_data_laporan_api_client.dart';
import 'package:fitur_buat_laporan/data/mapper/get_data_laporan_mapper.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';

class GetDataLaporanRepositoryImpl implements IGetDataLaporanRepository{
  final _apiClient = GetDataLaporanApiClient();
  final _mapper = GetDataLaporanMapper();

  @override
  Future<ApiResponse> getDataLaporan(GeneratePdfParameterDto param) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getDataLaporan(param),
      getModelFromBody: _mapper.fromBodyToListDataLaporan
    );
  }

}