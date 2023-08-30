import 'dart:convert';

import 'package:common/response/api_response.dart';
import 'package:csv/csv.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_buat_laporan/domain/model/data_laporan.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:fitur_buat_laporan/domain/model/transaksi_barang_summary.dart';
import 'package:fitur_buat_laporan/domain/repository/i_get_data_laporan_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class PilihBulanTahunProvider extends ChangeNotifier {
  final IGetDataLaporanRepository _repository;
  PilihBulanTahunProvider({
    required IGetDataLaporanRepository repository
  }) : _repository = repository;

  Month _choosenMonth = Month.values[DateTime.now().month - 1];
  Month get choosenMonth => _choosenMonth;
  void onChangeChoosenMonth(Month? newValue){
    if (newValue != null) {
      _choosenMonth = newValue;
    }
  }

  final yearController = TextEditingController(
    text: DateTime.now().year.toString()
  );
  int? get _year => int.tryParse(yearController.text);
  String? yearError;

  bool goNext = false;
  void submit(){
    if (_year != null){
      yearError = null;
      goNext = true;
    }
    else {
      yearError = "Tahun tidak valid";
    }
    notifyListeners();
  }

  ApiResponse? downloadCSVProgress;
  void downloadCSV() async {
    if (kIsWeb) {
      if (downloadCSVProgress is! ApiResponseLoading) {
        downloadCSVProgress = ApiResponseLoading();
        notifyListeners();

        // TODO : TAMBAHIN VALIDATION YEAR

        downloadCSVProgress = await _repository.getDataLaporan(pdfParameter);
        if (downloadCSVProgress is ApiResponseFailed) {
          Fluttertoast.showToast(
            msg: (downloadCSVProgress as ApiResponseFailed).error.toString()
          );
        }
        else if (downloadCSVProgress is ApiResponseSuccess<List<DataLaporan>>) {
          final data =
            (downloadCSVProgress as ApiResponseSuccess<List<DataLaporan>>).data!;

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
            // prepare
            final bytes = utf8.encode(csv);
            final blob = html.Blob([bytes]);
            final url = html.Url.createObjectUrlFromBlob(blob);
            final anchor = html.document.createElement('a') as html
                .AnchorElement
              ..href = url
              ..style.display = 'none'
              ..download = "laporan_${choosenMonth.name}_${yearController.text}.csv";
            html.document.body!.children.add(anchor);

            // download
            anchor.click();

            // cleanup
            html.document.body!.children.remove(anchor);
            html.Url.revokeObjectUrl(url);
          } catch (e) {
            Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 5);
          }
        }

        notifyListeners();
      }
    }
  }

  GeneratePdfParameterDto get pdfParameter => GeneratePdfParameterDto(
    month: _choosenMonth.intValue,
    year: _year!
  );
}