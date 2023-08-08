
import 'package:common/domain/model/pengajuan.dart';
import 'package:common/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class InputPengajuanProvider extends ChangeNotifier {
  InputPengajuanProvider({
    Pengajuan? initialData,
  }) :
    tanggal = initialData == null ?
      DateTime.now() :
      IntlFormatter.stringToDateTime(initialData.tanggal),
    jam = initialData == null ?
        TimeOfDay.now() :
        IntlFormatter.stringToTimeOfDay(initialData.jam),
    tipePengajuanController = TextEditingController(text: initialData?.tipe ?? ""),
    namaController = TextEditingController(text: initialData?.nama ?? ""),
    sectionController = TextEditingController(text: initialData?.section ?? "");

  DateTime tanggal;
  TimeOfDay jam;
  final TextEditingController tipePengajuanController;
  final TextEditingController namaController;
  final TextEditingController sectionController;

  String? tanggalError;
  String? jamError;
  String? tipePengajuanError;
  String? namaError;

  void onTanggalChange(DateTime newValue){
    tanggal = newValue;
    notifyListeners();
  }
  void onJamChange(TimeOfDay newValue){
    jam = newValue;
    notifyListeners();
  }

  @override
  void dispose(){
    namaController.dispose();
    sectionController.dispose();
    super.dispose();
  }
}