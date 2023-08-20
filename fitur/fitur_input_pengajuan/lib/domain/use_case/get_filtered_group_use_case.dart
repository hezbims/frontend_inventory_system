import 'package:common/response/api_response.dart';
import 'package:common/domain/model/group.dart';

class GetFilteredGroupUseCase {
  Future<ApiResponse> filter({
    required Future<ApiResponse> apiResponse,
    required String keyword
  }) async {
    try {
      final response = await apiResponse;
      if (response is ApiResponseSuccess<List<Group>>) {
        return ApiResponseSuccess(
          data: response.data!.where(
            (group) =>
              group.namaGroup.toLowerCase()
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