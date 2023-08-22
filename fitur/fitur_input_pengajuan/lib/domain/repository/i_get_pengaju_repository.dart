import 'package:common/response/api_response.dart';

abstract class IGetPengajuRepository {
  Future<ApiResponse> getPengaju(int isPemasok);
}