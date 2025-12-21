import 'dart:convert';

import 'package:common/domain/model/common_domain_error.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/service/i_time_service.dart';
import 'package:common/presentation/toast/my_toast.dart';
import 'package:csv/csv.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:fitur_buat_laporan/domain/repository/i_reporting_repository.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import '../../domain/service/i_download_service.dart';
import '../../domain/service/i_monthly_report_pdf_generator.dart';

class PilihBulanTahunProvider extends ChangeNotifier {
  final IReportingRepository _reportingRepository;
  final IDownloadService _downloadService;
  final IMonthlyReportPdfGenerator _monthlyReportPdfGenerator;

  PilihBulanTahunProvider({
    required IGetDataLaporanRepository repository,
    required IDownloadService downloadService,
    required IReportingRepository reportingRepository,
    required IMonthlyReportPdfGenerator monthlyReportPdfGenerator,
    required ITimeService timeService,
  }) : _downloadService = downloadService,
        _reportingRepository = reportingRepository,
        _monthlyReportPdfGenerator = monthlyReportPdfGenerator,
        _choosenMonth = Month.values[timeService.now.month - 1],
        yearController = TextEditingController(text: timeService.now.year.toString());

  @override
  void dispose() {
    yearController.dispose();
    super.dispose();
  }

  Month _choosenMonth;
  Month get choosenMonth => _choosenMonth;
  void onChangeChoosenMonth(Month? newValue){
    if (newValue != null) {
      _choosenMonth = newValue;
    }
  }
  int get month => _choosenMonth.intValue;

  final TextEditingController yearController;
  int? get year => int.tryParse(yearController.text);
  String? yearError;

  bool goNext = false;
  void submit(){
    if (year != null){
      yearError = null;
      goNext = true;
    }
    else {
      yearError = "Tahun tidak valid";
    }
    notifyListeners();
  }

  ResponseWrapper<List<DataLaporan>, CommonDomainError>? _downloadPdfDataProgress;
  ResponseWrapper<List<DataLaporan>, CommonDomainError>? get downloadPdfDataProgress => _downloadPdfDataProgress;

  void Function()? get downloadPdf {
    if (_downloadPdfDataProgress is ResponseLoading){
      return null;
    }
    return _downloadPdf;
  }

  void _downloadPdf() async {
    if (_downloadPdfDataProgress is ResponseLoading) {
      return;
    }

    final String? newYearError = _validateYear();
    yearError = newYearError;
    if (newYearError != null) {
      _downloadPdfDataProgress = null;
      notifyListeners();
      return;
    }

    _downloadPdfDataProgress = ResponseLoading();
    notifyListeners();

    final currentMonth = _choosenMonth;
    final currentYear = year!;

    final result = await _reportingRepository.getMonthlyReport(
        year: currentYear, month: currentMonth.intValue);

    if (result is ResponseSucceed<List<DataLaporan>, CommonDomainError>){
      final pdf = await _monthlyReportPdfGenerator.generatePdf(
          data: result.data,
          mainHeaderText: "MONTHLY REPORT ${currentMonth.name.toUpperCase()} $currentYear");

      await _downloadService.downloadFile(
        pdf,
        _getMonthlyReportFileNames(month: currentMonth, year: currentYear, fileType: _FileType.pdf)
      );
    } else if (result is ResponseFailed<List<DataLaporan>, CommonDomainError>){
      MyToast.handleCommonDomainError(result.error);
    }

    _downloadPdfDataProgress = result;
    notifyListeners();
  }

  String? _validateYear(){
    final currentYear = year;
    if (currentYear == null || currentYear <= 0) {
      return "Year is invalid";
    }

    return null;
  }

  ResponseWrapper<List<DataLaporan>, CommonDomainError>? _downloadCSVProgress;
  ResponseWrapper<List<DataLaporan>, CommonDomainError>? get downloadCSVProgress =>
      _downloadCSVProgress;
  void Function()? get downloadCSV {
    if (downloadCSVProgress is ResponseLoading){
      return null;
    }
    return _downloadCSV;
  }

  void _downloadCSV() async {
    if (downloadCSVProgress is ResponseLoading) {
      return;
    }

    final String? newYearError = _validateYear();
    yearError = newYearError;
    if (newYearError != null){
      _downloadCSVProgress = null;
      notifyListeners();
      return;
    }
    final currentYear = year!;
    final currentMonth = _choosenMonth;

    _downloadCSVProgress = ResponseLoading();
    notifyListeners();

    final currentDownloadCsvProgress = await _reportingRepository.getMonthlyReport(
        month: month, year: year!
    );
    _downloadCSVProgress = currentDownloadCsvProgress;
    switch(currentDownloadCsvProgress){
      case ResponseFailed<List<DataLaporan>, CommonDomainError>():
        MyToast.handleCommonDomainError(currentDownloadCsvProgress.error);
      case ResponseSucceed<List<DataLaporan>, CommonDomainError>():
        final data = currentDownloadCsvProgress.data;

        List<TransaksiBarangSummary> listBarang = [
          for (int i = 0 ; i < data.length ; i++)
            ...data[i].barang
        ];


        List<List<Object>> csvList = [
          [
            'NO',
            'ITEM NO',
            'ITEM DESCRIPTION',
            'LOCATION',
            'UOM',
            'STD STOCK',
            'LAST MONTH STOCK',
            'STOCK_IN',
            'STOCK_OUT',
            'STOCK_ACTUAL',
            'UNIT_PRICE',
            'AMOUNT',
          ]
        ];

        csvList.addAll(
            listBarang.mapIndexed(
                    (index , dataBarang) {
                  return [
                    index + 1,
                    dataBarang.kodeBarang,
                    dataBarang.namaBarang,
                    dataBarang.lokasiRak,
                    dataBarang.uom,
                    dataBarang.minStock,
                    dataBarang.lastMonthStock,
                    dataBarang.totalMasuk,
                    dataBarang.totalKeluar,
                    dataBarang.currentStock,
                    dataBarang.unitPrice,
                    dataBarang.amount,
                  ];
                }
            ).toList()
        );

        final csv = const ListToCsvConverter().convert(csvList);

        try {
          final bytes = utf8.encode(csv);
          _downloadService.downloadFile(
              bytes,
              _getMonthlyReportFileNames(month: currentMonth, year: currentYear, fileType: _FileType.csv));

        } catch (e) {
          MyToast.showToast(msg: e.toString(), toastLength: MyToastLength.LONG);
        }
      default:
        throw Exception("Impossible");
    }

    notifyListeners();
  }
  
  String _getMonthlyReportFileNames({
    required Month month,
    required int year,
    required _FileType fileType,
  }){
    return "${year}_${month.intValue.toString().padLeft(2, '0')}_monthly_report.${fileType.name}";
  }
  
  
}

enum _FileType {
  csv, pdf
}