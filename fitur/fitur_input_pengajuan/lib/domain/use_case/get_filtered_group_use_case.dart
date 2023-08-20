import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';

class GetFilteredGroupUseCase {
  Future<ApiResponse> filter({
    required Future<ApiResponse> apiResponse,
    required String keyword
  }) async {
    try {
      final response = await apiResponse;
      if (response is ApiResponseSuccess<List<Pengaju>>) {
        return ApiResponseSuccess(
          data: response.data!.where(
            (group) =>
              group.nama.toLowerCase()
                  .contains(keyword.toLowerCase())
          ).toList()
        );
      }
      else {
        return response;
      }
    } catch (e) {
      return ApiResponseFailed(
        error: e.toString()
      );
    }
  }
}