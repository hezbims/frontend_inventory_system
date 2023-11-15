import 'package:common/response/api_response.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';

class GetSortedGroupUseCase {
  final IPengajuRepository _repository;
  final bool _isPemasok;
  GetSortedGroupUseCase({
    required IPengajuRepository repository,
    required bool isPemasok,
  }) : _repository = repository , _isPemasok = isPemasok;

  Future<ApiResponse> get() async {
    try {
      final apiResponse = await _repository.getPengaju(isPemasok: _isPemasok);
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