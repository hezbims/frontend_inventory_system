import 'package:common/response/api_response.dart';

abstract class IStockBarangRepository {
  Future<ApiResponse> getAllStockBarang();
}