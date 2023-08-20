import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/api_client/get_detail_pengajuan_api_client.dart';
import 'package:fitur_input_pengajuan/data/mapper/get_detail_pengajuan_mapper.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_get_detail_pengajuan_repository.dart';

class GetDetailPengajuanRepositoryImpl implements IGetDetailPengajuanRepository {
  final _apiClient = GetDetailPengajuanApiClient();
  final _mapper = GetDetailPengajuanMapper();

  @override
  Future<ApiResponse> getDetailPengajuan(int id) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getDetailPengajuan(id),
      getModelFromBody: _mapper.fromBodyToDetailPengajuan
    );
  }

}