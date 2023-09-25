import 'package:common/response/api_response.dart';
import 'package:common/domain/model/pengaju.dart';

abstract class ICreatePengajuRepository {
  Future<ApiResponse> createPengaju(Pengaju pengaju);
}