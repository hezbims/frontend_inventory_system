import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/api_client/create_pengaju_api_client.dart';
import 'package:fitur_input_pengajuan/data/mapper/create_pengaju_mapper.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_create_pengaju_repository.dart';

class CreatePengajuRepositoryImpl implements ICreatePengajuRepository {
  final _apiClient = CreatePengajuApiClient();
  final _mapper = CreatePengajuMapper();
  @override
  Future<ApiResponse> createPengaju(Pengaju pengaju) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.createPengaju(
        _mapper.fromPengajuToBody(pengaju)
      ),
    );
  }

}