import 'package:dependencies/get_it.dart';
import 'package:fitur_buat_laporan/data/repository/get_data_laporan_repository_impl.dart';
import 'package:fitur_buat_laporan/data/repository/reporting_repository_impl.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:fitur_buat_laporan/domain/repository/i_reporting_repository.dart';
import 'package:fitur_buat_laporan/domain/service/i_monthly_report_pdf_generator.dart';
import 'package:fitur_buat_laporan/presentation/provider/preview_laporan_provider.dart';
import 'package:fitur_buat_laporan/presentation/service/monthly_report_pdf_generator.dart';

import '../data/service/download_service.dart';
import '../domain/service/i_download_service.dart';

void fiturBuatLaporanDi(){
  GetIt.I.registerFactory<IGetDataLaporanRepository>(
    () => GetDataLaporanRepositoryImpl()
  );

  GetIt.I.registerFactoryParam(
    (GeneratePdfParameterDto param, _) => PreviewLaporanProvder(
      repository: GetIt.I.get(), param: param
    ),
  );

  GetIt.I.registerFactory<IDownloadService>(() => DownloadService());

  GetIt.I.registerFactory<IMonthlyReportPdfGenerator>(() => MonthlyReportPdfGenerator());

  GetIt.I.registerFactory<IReportingRepository>(() => ReportingRepositoryImpl());
}