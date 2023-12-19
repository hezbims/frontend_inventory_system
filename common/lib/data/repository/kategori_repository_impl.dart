import 'package:common/data/api_client/kategori_api_client.dart';
import 'package:common/data/mapper/kategori/get_kategori_mapper.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/mapper/kategori/post_kategori_error_mapper.dart';
import 'package:common/domain/repository/i_kategori_repository.dart';
import 'package:common/response/api_response.dart';

class KategoriRepositoryImpl implements IKategoriRepository{
  final _apiClient = KategoriApiClient();
  final _postKategoriErrorMapper = PostKategoriErrorMapper();

  @override
  Future<ApiResponse> getAllKategori() {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getAllKategori(),
      getModelFromBody: GetKategoriMapper.getListKategoriFromBody,
      isPagination: false
    );
  }

  @override
  Future<ApiResponse> addNewKategori(String namaKategori) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.addNewKategori(namaKategori),
      getModelFromBody: null,
      getErrorMessageFromBody: _postKategoriErrorMapper.getErrorFromBody,
      isPagination: false,
    );
  }


}