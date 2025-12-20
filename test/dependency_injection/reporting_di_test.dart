import 'package:dependencies/get_it.dart';
import 'package:fitur_buat_laporan/data/repository/reporting_repository_impl.dart';
import 'package:fitur_buat_laporan/data/service/download_service.dart';
import 'package:fitur_buat_laporan/domain/repository/i_reporting_repository.dart';
import 'package:fitur_buat_laporan/domain/service/i_download_service.dart';
import 'package:fitur_buat_laporan/domain/service/i_monthly_report_pdf_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_system/dependency_injection/setup_main_dependency_injection.dart';

void main(){
  setUp((){
    setupMainDependencyInjection();
  });

  tearDown((){
    GetIt.I.reset();
  });

  test("Reporting dependency should registered correctly", (){
    final reportingRepository = GetIt.I.get<IReportingRepository>();
    final downloadService = GetIt.I.get<IDownloadService>();
    final monthlyReportPdfGenerator = GetIt.I.get<IMonthlyReportPdfGenerator>();

    expect(reportingRepository, isA<ReportingRepositoryImpl>());
    expect(downloadService, isA<DownloadService>());
    expect(monthlyReportPdfGenerator, isA<IMonthlyReportPdfGenerator>());
  });
}