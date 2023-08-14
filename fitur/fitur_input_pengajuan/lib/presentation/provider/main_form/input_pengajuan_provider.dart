

import 'package:common/domain/model/pengajuan.dart';
import 'package:common/utils/date_formatter.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:common/domain/model/group.dart';
import 'package:flutter/material.dart';

class InputPengajuanProvider extends ChangeNotifier {
  InputPengajuanProvider({
    Pengajuan? initialData,
  })  :
    tanggal = initialData == null ?
      DateTime.now() :
      IntlFormatter.stringToDateTime(initialData.tanggal),
    jam = initialData == null ?
        TimeOfDay.now() :
        IntlFormatter.stringToTimeOfDay(initialData.jam),
    tipePengajuan = initialData?.tipe ?? "Pengeluaran",
    namaController = TextEditingController(text: initialData?.nama ?? ""),
    _group = initialData?.group;

  DateTime tanggal;
  TimeOfDay jam;
  String? tipePengajuan;

  final TextEditingController namaController;
  Group? _group;
  Group? get group => _group;
  void onChangeGroup(Group newGroup) {
    _group = newGroup;
    notifyListeners();
  }

  List<BarangTransaksi> listBarangTransaksi = [];

  String? tanggalError;
  String? jamError;
  String? tipePengajuanError;
  String? namaError;
  String? groupError;

  void onTanggalChange(DateTime newValue){
    tanggal = newValue;
    notifyListeners();
  }
  void onJamChange(TimeOfDay newValue){
    jam = newValue;
    notifyListeners();
  }
  void onTipePengajuanChange(String? newValue){
    if (newValue != null){
      tipePengajuan = newValue;
      notifyListeners();
    }
  }
  void addNewBarang(List<BarangTransaksi> newBarang) {
    listBarangTransaksi.addAll(newBarang);
    notifyListeners();
  }
  void deleteBarang(BarangTransaksi oldBarang) {
    listBarangTransaksi.remove(oldBarang);
    notifyListeners();
  }

  @override
  void dispose(){
    namaController.dispose();
    super.dispose();
  }
}