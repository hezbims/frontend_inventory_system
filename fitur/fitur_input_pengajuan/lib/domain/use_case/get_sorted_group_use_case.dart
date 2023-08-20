import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_group_repository.dart';

class GetSortedGroupUseCase {
  final IGroupRepository _repository;
  GetSortedGroupUseCase({
    required IGroupRepository repository,
  }) : _repository = repository;

  Future<ApiResponse> get() async {
    try {
      final apiResponse = await _repository.getGroups();
      if (apiResponse is ApiResponseSuccess<List<Pengaju>>){
        final data = apiResponse.data!;
        final sortedData = data..sort(
          (a , b) =>
            a.nama.toLowerCase()
              .compareTo(b.nama.toLowerCase())
        );

        return ApiResponseSuccess(data: sortedData);
      }
      else {
        return ApiResponseFailed();
      }
    } catch (e){
      return ApiResponseFailed();
    }
  }
}