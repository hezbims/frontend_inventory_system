import 'package:common/response/api_response.dart';

abstract class IBarangRepository {
  Future<ApiResponse> getStockBarang({
    required int pageNumber,
    required String keyword,
    required int idKategori,
  });
  Future<ApiResponse> getDetailBarang({required int id});
}