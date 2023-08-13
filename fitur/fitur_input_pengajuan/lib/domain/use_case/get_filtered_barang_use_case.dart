import 'package:common/domain/model/barang.dart';
import 'package:common/response/api_response.dart';

class GetFilteredBarangFromApiUseCase {
  Future<ApiResponse> get({
    required Future<ApiResponse> future,
    required String keyword,
  }) {
    return future.then(
      (apiResponse) {
        if (apiResponse is ApiResponseSuccess<List<Barang>>){
          final List<Barang> filteredData = apiResponse.data!.where(
            (dataBarang){
              return dataBarang.nama.toLowerCase().contains(
                keyword.toLowerCase()
              );
            }
          ).toList();

          return ApiResponseSuccess(data: filteredData);
        }
        else {
          return apiResponse;
        }
      }
    ).catchError((error){
      return ApiResponseFailed(
        message: error.toString(),
      );
    });
  }
}