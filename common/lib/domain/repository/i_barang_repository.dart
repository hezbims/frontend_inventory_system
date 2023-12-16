import 'package:common/response/api_response.dart';
import 'package:dependencies/file_picker.dart';

abstract class IBarangRepository {
  Future<ApiResponse> getStockBarangPaginated({
    required int pageNumber,
    required String keyword,
    required int idKategori,
  });
  Future<ApiResponse> getDetailBarang({required int id});
  Future<ApiResponse> uploadBarangByExcel({
    required PlatformFile file,
    required bool isUpsert,
  });
  Future<ApiResponse> downloadCsvTemplate();
}