import 'package:common/domain/model/kategori.dart';
import 'package:common/response/api_response.dart';

class FilterKategoriByKeywordUseCase {
  Future<ApiResponse> filter({
    required Future<ApiResponse> initialResponse,
    required String keyword
  }) async {
    final response = await initialResponse;
    if (response is! ApiResponseSuccess) {
      return response;
    } else if (response is ApiResponseSuccess<List<Kategori>>){
      return ApiResponseSuccess(
        data : response.data!.where(
          (kategori) =>
            kategori.nama.toLowerCase().contains(keyword.toLowerCase())
        ).toList()
      );
    }
    else {
      throw Exception("Error di filter kategori by keyword");
    }
  }
}