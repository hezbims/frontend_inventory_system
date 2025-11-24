import 'package:common/data/api_client/barang_api_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/mapper/barang/csv_template_saver.dart';
import 'package:common/data/mapper/barang/get_detail_barang_mapper.dart';
import 'package:common/data/mapper/barang/get_list_barang_mapper.dart';
import 'package:common/data/mapper/barang/submit_csv_error_mapper.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/page_result.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/file_picker.dart';

class BarangRepositoryImpl implements IBarangRepository {
  final _getDetailBarangMapper = GetDetailBarangMapper();
  final _csvTemplateSaver = CsvTemplateSaver();
  final _submitCsvErrorMapper = SubmitCsvErrorMapper();

  final _apiClient = BarangApiClient();

  @override
  Future<ApiResponse> getStockBarangPaginated({
    required int pageNumber,
    required String keyword,
    required int idKategori
  }) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getBarangPaginated(
        pageNumber: pageNumber ,
        keyword: keyword,
        idKategori: idKategori,
      ),
      getModelFromBody: GetListBarangMapper.getListBarangFromBody,
      isPagination: true,
    );
  }

  @override
  Future<ApiResponse> getDetailBarang({required int id}) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.getDetailBarang(id: id),
      getModelFromBody: _getDetailBarangMapper.fromBodyToBarang,
    );
  }

  @override
  Future<ApiResponse> uploadBarangByCsv({
    required PlatformFile file,
    required bool isUpsert
  }) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.submitExcelDataBarang(
        file: file, isUpsert: isUpsert
      ),
      getErrorMessageFromBody: _submitCsvErrorMapper.mapError
    );
  }

  @override
  Future<ApiResponse> downloadCsvTemplate() {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.downloadCsvTemplate(),
      getModelFromBody: _csvTemplateSaver.saveCsvFile
    );
  }

  @override
  Future<ResponseWrapper<
      PageResult<Barang>,
      Object?
  >> getStockBarangPaginatedV2({
    required int? pageNumber, 
    required String? keyword, 
    required int? idKategori
  }) {
    return ApiRequestProcessor.processV2(
      apiRequest: _apiClient.getBarangPaginatedV2(
        pageNumber: pageNumber, 
        keyword: keyword, 
        idKategori: idKategori
      ),
      getModelFromBody: GetListBarangMapper.getPageBarangFromBody,
    );
  }
}