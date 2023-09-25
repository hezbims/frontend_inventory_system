import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/mapper/pengaju/create_pengaju_mapper.dart';
import 'package:common/data/mapper/pengaju/get_pengaju_mapper.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/response/api_response.dart';
import 'package:common/data/api_client/pengaju_api_client.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';

class PengajuRepositoryImpl implements IPengajuRepository{
  final _apiClient = PengajuApiClient();
  final _mapper = GetPengajuMapper();
  final _createPengajuMapper = CreatePengajuMapper();

  @override
  Future<ApiResponse> getPengaju(bool isPemasok){
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getPengaju(isPemasok),
      getModelFromBody: _mapper.fromBodyToListPengaju,
    );
  }
  @override
  Future<ApiResponse> createPengaju(Pengaju pengaju) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.createPengaju(
          _createPengajuMapper.fromPengajuToBody(pengaju)
      ),
    );
  }
}