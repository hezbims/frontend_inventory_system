import 'dart:async';
import 'dart:typed_data';

import 'package:common/domain/model/common_domain_error.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common_test_support/mock/mock_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies_test_support/mocktail.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/domain/repository/i_reporting_repository.dart';
import 'package:fitur_buat_laporan/domain/service/i_download_service.dart';
import 'package:fitur_buat_laporan/domain/service/i_monthly_report_pdf_generator.dart';
import 'package:fitur_buat_laporan/presentation/page/download_monthly_report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reporting_test_support/mock/mock_download_service.dart';
import 'package:reporting_test_support/mock/mock_monthly_report_pdf_generator.dart';
import 'package:reporting_test_support/mock/mock_reporting_repository.dart';
import 'package:reporting_test_support/robot/download_monthly_report_dialog_robot.dart';

void main() {
  const currentYear = 2023;
  const currentMonth = 8; // Agustus
  final mockTokenManager = MockTokenManager();
  final mockDownloadService = MockDownloadService();
  final mockReportingRepository = MockReportingRepository();
  final mockMonthlyReportPdfGenerator = MockMonthlyReportPdfGenerator();

  setUpAll((){
    registerFallbackValue(Uint8List(0));

    GetIt.I.registerSingleton<IReportingRepository>(mockReportingRepository);
    GetIt.I.registerSingleton<ITokenManager>(mockTokenManager);
    GetIt.I.registerSingleton<IDownloadService>(mockDownloadService);
    GetIt.I.registerSingleton<IMonthlyReportPdfGenerator>(mockMonthlyReportPdfGenerator);

    when(() => mockDownloadService.downloadFile(any(), any())).thenAnswer((_) async {});

    when(() => mockMonthlyReportPdfGenerator.generatePdf(
        data: any(named: 'data'),
        mainHeaderText: any(named: 'mainHeaderText'))).thenAnswer((_) async =>
        Uint8List(0)
    );


    // never complete to simulate loading process
    final neverEndingReportingData = Completer<ResponseWrapper<List<DataLaporan>, CommonDomainError>>();

    when(() => mockReportingRepository
        .getMonthlyReport(
          year: any(named: 'year'),
        month: any(named: 'month'))).thenAnswer((_) async =>
        ResponseSucceed(data: [
          DataLaporan(
              namaKategori: "kat-1",
              barang: [
                TransaksiBarangSummary(
                    kodeBarang: "R324-1",
                    nomorRak: 5,
                    nomorLaci: 4,
                    nomorKolom: 3,
                    namaBarang: 'barang-1',
                    uom: 'piece',
                    minStock: 2,
                    lastMonthStock: 3,
                    currentStock: 4,
                    totalMasuk: 5,
                    totalKeluar: 6,
                    unitPrice: 25000000,
                    amount: 1
                )
              ]
          ),
          DataLaporan(
              namaKategori: "ket-2",
              barang: [
                TransaksiBarangSummary(
                    kodeBarang: "R324-1",
                    nomorRak: 5,
                    nomorLaci: 4,
                    nomorKolom: 3,
                    namaBarang: 'barang-1',
                    uom: 'piece',
                    minStock: 2,
                    lastMonthStock: 3,
                    currentStock: 4,
                    totalMasuk: 5,
                    totalKeluar: 6,
                    unitPrice: 25000000,
                    amount: 1
                ),
                TransaksiBarangSummary(
                    kodeBarang: "R324-1",
                    nomorRak: 5,
                    nomorLaci: 4,
                    nomorKolom: 3,
                    namaBarang: 'barang-1',
                    uom: 'piece',
                    minStock: 2,
                    lastMonthStock: 3,
                    currentStock: 4,
                    totalMasuk: 5,
                    totalKeluar: 6,
                    unitPrice: 25000000,
                    amount: 1
                ),
              ]
          ),
        ]));
    when(() => mockReportingRepository
        .getMonthlyReport(year: 1999, month: 1)).thenAnswer((_) => neverEndingReportingData.future);
  });

  Future<void> setupDownloadMonthlyReportDialog(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Material(
            child: DownloadMonthlyReportDialog(downloadService: mockDownloadService,))));
  }

  tearDown(() {
    // debugDumpRenderTree();
    debugDumpApp();
  });

  testWidgets('Screen should be initiated with current year and month', (tester) async {
    throw UnimplementedError();
  });

  group("User Download CSV", (){
    testWidgets('CSV file should have correct name and correct content, '
        'when user trying to download with valid year and month', (tester) async {
      throw UnimplementedError();
    });

    testWidgets("Error should be displayed when inputted year is invalid", (tester) async {
      final robot = DownloadMonthlyReportDialogRobot(tester);
      await setupDownloadMonthlyReportDialog(tester);

      await robot.changeYear("-2019");
      await robot.downloadCsv();

      expect(find.text("Year is invalid"), findsOneWidget);
      robot.expectDownloadCsvButtonEnabled();
    });

    testWidgets("When CSV downloading is in progress, "
        "the download CSV button must be disabled and has downloading indicator", (tester) async {
      final robot = DownloadMonthlyReportDialogRobot(tester);
      await setupDownloadMonthlyReportDialog(tester);

      // select specific month and year to trigger never ending fetch
      await robot.changeMonth(Month.january);
      await robot.changeYear("1999");
      await robot.downloadCsv();

      robot.expectDownloadCSVButtonDisabled();
      robot.expectDownloadCsvButtonHasDownloadingIndicator();
    });
  });

  group("User Download PDF", (){

    // Untuk testing apakah PDF dibentuk dengan visual yang benar, lakukan testing secara manual.
    testWidgets('PDF file should correctly named,'
        'when user trying to download with valid year and month', (tester) async {
      final robot = DownloadMonthlyReportDialogRobot(tester);
      await setupDownloadMonthlyReportDialog(tester);

      const selectedMonth = Month.february;
      const selectedYear = 2010;

      await robot.changeMonth(selectedMonth);
      await robot.changeYear(selectedYear.toString());
      await robot.downloadPdf();

      verify(() => mockDownloadService.downloadFile(any(), "2010_02_monthly_report.pdf")).called(1);
      robot.expectDownloadCsvButtonEnabled();
    });


    testWidgets("Error should be displayed when inputted year is invalid", (tester) async {
      final robot = DownloadMonthlyReportDialogRobot(tester);
      await setupDownloadMonthlyReportDialog(tester);

      await robot.changeYear("-2019");
      await robot.downloadPdf();

      expect(find.text("Year is invalid"), findsOneWidget);
      robot.expectDownloadPdfButtonEnabled();
    });


    testWidgets("When PDF downloading is in progress, "
        "the download PDF button must be disabled and has downloading indicator", (tester) async {
      final robot = DownloadMonthlyReportDialogRobot(tester);
      await setupDownloadMonthlyReportDialog(tester);

      // select specific month and year to trigger never ending fetch
      await robot.changeMonth(Month.january);
      await robot.changeYear("1999");
      await robot.downloadPdf();

      robot.expectDownloadPdfButtonDisabled();
      robot.expectDownloadPdfButtonHasDownloadingIndicator();
    });
  });
}
