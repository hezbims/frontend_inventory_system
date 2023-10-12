import 'package:common/response/api_response.dart';

abstract class IBarangRepository {
  Future<ApiResponse> getStockBarang(int pageNumber , String keyword);
  Future<ApiResponse> getDetailBarang({required int id});
}