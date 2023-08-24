import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:flutter/material.dart';

class PilihBulanTahunProvider extends ChangeNotifier {
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
      goNext = true;
    }
    else {
      yearError = "Tahun tidak valid";
    }
    notifyListeners();
  }

  GeneratePdfParameterDto get pdfParameter => GeneratePdfParameterDto(
    month: _choosenMonth.intValue,
    year: _year!
  );
}