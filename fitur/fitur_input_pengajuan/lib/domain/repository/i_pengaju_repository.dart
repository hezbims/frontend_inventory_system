import 'package:common/response/api_response.dart';

abstract class IPengajuRepository {
  Future<ApiResponse> getPengaju(int isPemasok);
}