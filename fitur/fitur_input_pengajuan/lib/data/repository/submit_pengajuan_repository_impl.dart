import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/api_client/submit_pengajuan_api_client.dart';
import 'package:fitur_input_pengajuan/data/mapper/submit_pengajuan_mapper.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';

class SubmitPengajuanRepositoryImpl implements ISubmitPengajuanRepository {
  final _apiClient = SubmitPengajuanApiClient();
  final _mapper = SubmitPengajuanMapper();

  @override
  Future<ApiResponse> submitData(Pengajuan data) async {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.submitData(_mapper.fromPengajuanToJson(data)),
    );
  }

  @override
  Future<ApiResponse> deletePengajuan(int idPengajuan) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.deletePengajuan(idPengajuan),
    );
  }

}