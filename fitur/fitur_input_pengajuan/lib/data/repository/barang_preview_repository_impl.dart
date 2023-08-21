import 'package:common/data/api_client/barang_api_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/mapper/get_barang_preview_mapper.dart';

class BarangPreviewRepositoryImpl implements IBarangRepository {
  final _apiClient = BarangApiClient();
  final _mapper = GetBarangPreviewMapper();

  @override
  Future<ApiResponse> getStockBarang(int pageNumber, String keyword) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getBarang(pageNumber, keyword),
      getModelFromBody: _mapper.fromBodyToListBarangPreview,
      isPagination: true,
    );
  }

}