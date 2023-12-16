import 'package:common/domain/model/barang.dart';
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
    var listBarangResponse = await _repository.getStockBarangPaginated(
      pageNumber: pageNumber,
      keyword: keyword,
      idKategori: 0,
    );

    if (listBarangResponse is ApiResponseFailed){
      return listBarangResponse;
    }

    listBarangResponse = listBarangResponse as ApiResponseSuccess<List<Barang>>;

    final listBarangPreview = _mapper.fromListBarangToListBarangPreview(
      listBarangResponse.data!,
    );
    return ApiResponseSuccess(
      data: listBarangPreview,
      isNextDataExist: listBarangResponse.isNextDataExist
    );
  }
}