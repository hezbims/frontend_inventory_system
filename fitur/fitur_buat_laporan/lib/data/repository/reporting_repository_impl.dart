import 'package:common/data/api_client/inventory_system_http_client.dart';
import 'package:common/domain/model/common_domain_error.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_buat_laporan/domain/repository/i_reporting_repository.dart';

import '../../domain/model/data_laporan.dart';
import '../mapper/get_data_laporan_mapper.dart';

class ReportingRepositoryImpl implements IReportingRepository {

  final _mapper = GetDataLaporanMapper();
  final InventorySystemHttpClient _httpClient;

  ReportingRepositoryImpl(
    InventorySystemHttpClient httpClient
  ) : _httpClient = httpClient;

  @override
  Future<ResponseWrapper<List<DataLaporan>, CommonDomainError>> getMonthlyReport(
      {required int year, required int month}) async {
    try {
      final response = await _httpClient.doRequest(
        method: HttpMethod.get,
        endpoint: "kategori/laporan",
        headers: {
          'month': month,
          'year': year,
        }
      );

      return ResponseSucceed(data: _mapper
          .fromBodyToListDataLaporan(response.body));
    } catch (e) {
      CommonDomainError error;
      if (e is ClientException) {
        error = NotReachedError();
      }
      else {
        error = UnknownAppError();
      }

      return ResponseFailed(error: error);
    }
  }
}