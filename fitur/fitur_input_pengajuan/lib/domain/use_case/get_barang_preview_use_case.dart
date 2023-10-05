import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/data/mapper/get_barang_preview_mapper.dart';

class GetBarangPreviewUseCase {
  final IBarangRepository _repository;
  final _mapper = GetBarangPreviewMapper();
  GetBarangPreviewUseCase({
    required IBarangRepository repository
  }) : _repository = repository;

  Future<ApiResponse> call({
    required int pageNumber,
    required String keyword
  }) async {
    final listBarangResponse = await _repository.getStockBarang(
        pageNumber, keyword
    );

    if (listBarangResponse is ApiResponseFailed){
      return listBarangResponse;
    }
    final listBarangPreview = _mapper.fromListBarangToListBarangPreview(
        (listBarangResponse as ApiResponseSuccess).data
    );
    return ApiResponseSuccess(data: listBarangPreview);
  }
}