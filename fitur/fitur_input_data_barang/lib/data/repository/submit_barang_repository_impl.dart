import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_data_barang/data/api_client/submit_barang_api_client.dart';
import 'package:fitur_input_data_barang/data/mapper/submit_barang_mapper.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';
import 'package:fitur_input_data_barang/domain/repository/i_submit_barang_repository.dart';

class SubmitBarangRepositoryImpl implements ISubmitBarangRepository {
  final _apiClient = SubmitBarangApiClient();
  final _mapper = SubmitBarangMapper();
  @override
  Future<ApiResponse> submitDataBarang(SubmitBarangDto barang) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.submit(barang),
      getErrorMessageFromBody: _mapper.getAllError,
    );
  }

}