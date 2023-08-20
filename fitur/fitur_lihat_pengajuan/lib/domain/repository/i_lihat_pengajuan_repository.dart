import 'package:common/response/api_response.dart';

abstract class ILihatPengajuanRepository {
  Future<ApiResponse> getPengajuanPreview(int pageNumber);
}