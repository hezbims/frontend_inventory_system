import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/api_client/pengaju_api_client.dart';
import 'package:fitur_input_pengajuan/data/mapper/pengaju_mapper.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_pengaju_repository.dart';

class PengajuRepositoryImpl implements IPengajuRepository{
  final _apiClient = PengajuApiClient();
  final _mapper = PengajuMapper();

  @override
  Future<ApiResponse> getPengaju(int isPemasok){
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getPengaju(isPemasok),
      getModelFromBody: _mapper.fromBodyToListPengaju,
    );
  }
}