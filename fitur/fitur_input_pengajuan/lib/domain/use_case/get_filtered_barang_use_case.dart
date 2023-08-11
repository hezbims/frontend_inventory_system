import 'package:common/domain/model/barang.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/use_case/filter_barang_by_keyword_use_case.dart';

class GetFilteredBarangFromApiUseCase {
  final _barangFilter = FilterBarangByKeywordUseCase();

  Future<ApiResponse> get({
    required Future<ApiResponse> future,
    required String keyword,
  }) {
    return future.then(
      (apiResponse) {
        if (apiResponse is ApiResponseSuccess<List<Barang>>){
          final List<Barang> filteredData = _barangFilter.filter(
              data: apiResponse.data!, keyword: keyword
          );

          return ApiResponseSuccess(data: filteredData);
        }
        else {
          return apiResponse;
        }
      }
    );
  }
}