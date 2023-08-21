import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_pengaju_repository.dart';

class GetSortedGroupUseCase {
  final IPengajuRepository _repository;
  final int _isPemasok;
  GetSortedGroupUseCase({
    required IPengajuRepository repository,
    required int isPemasok,
  }) : _repository = repository , _isPemasok = isPemasok;

  Future<ApiResponse> get() async {
    try {
      final apiResponse = await _repository.getPengaju(_isPemasok);
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