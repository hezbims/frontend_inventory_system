import 'package:common/response/api_response.dart';

abstract class IGetDetailPengajuanRepository {
  Future<ApiResponse> getDetailPengajuan(int id);
}