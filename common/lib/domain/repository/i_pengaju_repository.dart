import 'package:common/domain/model/pengaju.dart';
import 'package:common/response/api_response.dart';

abstract class IPengajuRepository {
  Future<ApiResponse> getPengaju(bool isPemasok);
  Future<ApiResponse> createPengaju(Pengaju pengaju);
}