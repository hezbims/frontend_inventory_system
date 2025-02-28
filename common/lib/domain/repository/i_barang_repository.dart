import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/page_result.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/file_picker.dart';

abstract class IBarangRepository {
  Future<ApiResponse> getStockBarangPaginated({
    required int pageNumber,
    required String keyword,
    required int idKategori,
  });
  Future<ResponseWrapper<PageResult<Barang>, Object>> getStockBarangPaginatedV2({
    required int? pageNumber,
    required String? keyword,
    required int? idKategori,
  });
  Future<ApiResponse> getDetailBarang({required int id});
  Future<ApiResponse> uploadBarangByCsv({
    required PlatformFile file,
    required bool isUpsert,
  });
  Future<ApiResponse> downloadCsvTemplate();
}