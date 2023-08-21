import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:flutter/material.dart';

class InputPengajuanProvider extends ChangeNotifier {
  InputPengajuanProvider({
    required Pengajuan initialData,
  })  :
    tanggal = initialData.tanggal,
    jam = TimeOfDay.fromDateTime(initialData.tanggal),
    isPemasukan = initialData.isPemasok,
    _group = initialData.isPemasok == false ? initialData.pengaju : null,
    _pemasok = initialData.isPemasok == true ? initialData.pengaju : null,
    listBarangTransaksi = initialData.listBarangTransaksi;

  DateTime tanggal;
  TimeOfDay jam;
  bool? isPemasukan;
  final tipePengajuanList = const ['Pemasukan' , 'Pengeluaran'];
  String? get currentTipePengajuan {
    if (isPemasukan == null) {
      return null;
    } else if (isPemasukan == true) {
      return tipePengajuanList[0];
    } else {
      return tipePengajuanList[1];
    }
  }

  Pengaju? _group;
  Pengaju? get group => _group;
  void onChangeGroup(Pengaju newGroup) {
    _group = newGroup;
    notifyListeners();
  }
  Pengaju? _pemasok;
  Pengaju? get pemasok => _pemasok;
  void onChangePemasok(Pengaju newPemasok){
    _pemasok = newPemasok;
    notifyListeners();
  }

  List<BarangTransaksi> listBarangTransaksi;

  String? tanggalError;
  String? jamError;
  String? tipePengajuanError;
  String? namaError;
  String? groupError;
  String? pemasokError;

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
      isPemasukan = newValue == tipePengajuanList[0];
      notifyListeners();
    }
  }
  void setNewListBarang(List<BarangTransaksi> newBarang) {
    listBarangTransaksi = newBarang;
    notifyListeners();
  }
  void deleteBarang(BarangTransaksi oldBarang) {
    listBarangTransaksi.remove(oldBarang);
    notifyListeners();
  }
}