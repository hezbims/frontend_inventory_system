import 'package:common/response/api_response.dart';

abstract class ILihatPengajuanRepository {
  Future<ApiResponse> getPengajuanPreview({
    required int pageNumber,
    required String keyword,
  });
}