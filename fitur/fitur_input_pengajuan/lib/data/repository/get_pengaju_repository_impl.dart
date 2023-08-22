import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/api_client/get_pengaju_api_client.dart';
import 'package:fitur_input_pengajuan/data/mapper/get_pengaju_mapper.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_get_pengaju_repository.dart';

class GetPengajuRepositoryImpl implements IGetPengajuRepository{
  final _apiClient = GetPengajuApiClient();
  final _mapper = GetPengajuMapper();

  @override
  Future<ApiResponse> getPengaju(int isPemasok){
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getPengaju(isPemasok),
      getModelFromBody: _mapper.fromBodyToListPengaju,
    );
  }
}