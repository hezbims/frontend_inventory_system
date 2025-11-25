import 'package:common/domain/model/common_domain_error.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';

abstract class IReportingRepository {
  Future<ResponseWrapper<List<DataLaporan>, CommonDomainError>> getMonthlyReport({
    required int year, required int month});

}