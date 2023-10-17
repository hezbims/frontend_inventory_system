import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/domain/use_case/null_validation_use_case.dart';
import 'package:flutter/material.dart';

class MainFormProvider extends ChangeNotifier {
  final _nullValidator = NullValidationUseCase();
  final ISubmitPengajuanRepository _repository;
  final int? _id;
  final User _user;
  final StatusPengajuan? status;

  MainFormProvider({
    required User user,
    required Pengajuan? initialData,
    required ISubmitPengajuanRepository repository,
  })  : _user = user,
    status = initialData?.status,
    _repository = repository,
    _id = initialData?.id,
    tanggal = initialData?.tanggal ?? DateTime.now(),
    jam = initialData?.tanggal != null ?
            TimeOfDay.fromDateTime(initialData!.tanggal) :
            TimeOfDay.now(),
    isPemasukan = initialData?.pengaju?.isPemasok,
    _group = initialData?.pengaju?.isPemasok == false ?
                initialData?.pengaju : null,
    _pemasok = initialData?.pengaju?.isPemasok == true ?
                  initialData?.pengaju : null,
    listBarangTransaksi = initialData?.listBarangTransaksi ?? [];

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
  String? namaPemasokError;
  String? groupError;
  String? pemasokError;
  String? _listBarangTransaksiError;

  ApiResponse? submitResponse;
  void Function()? get submit {
    if (
      submitResponse is ApiResponseLoading
    ){
      return null;
    }
    return _submit;
  }
  void _submit() async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      tipePengajuanError =
          _nullValidator(isPemasukan, fieldName: "Tipe pengajuan");
      if (isPemasukan == true) {
        pemasokError = _nullValidator(_pemasok, fieldName: "Nama pemasok");
      }
      else if (isPemasukan == false) {
        groupError = _nullValidator(_group, fieldName: "Group");
      }
      notifyListeners();

      if (listBarangTransaksi.isEmpty && !_user.isAdmin){
        _listBarangTransaksiError = "Anda harus memilih minimal satu jenis barang!";
        Fluttertoast.showToast(
          msg: _listBarangTransaksiError!,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
        );
      }
      else {
        _listBarangTransaksiError = null;
      }

      // kalo semua validasi lolos
      if (canSubmit()){
        submitResponse = await _repository.submitData(
          Pengajuan(
            id: _id,
            tanggal: tanggal,
            pengaju: isPemasukan! ? _pemasok : _group,
            listBarangTransaksi: listBarangTransaksi,
            status: null,
          )
        );

        if (submitResponse is ApiResponseFailed){
          debugPrint("test submit response ${(submitResponse as ApiResponseFailed).error}");
          Fluttertoast.showToast(
            msg: (submitResponse as ApiResponseFailed).error.toString(),
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 5,
          );
        }
      }
      else {
        submitResponse = null;
      }
      notifyListeners();
    }
  }

  ApiResponse? _deletePengajuanResponse;
  ApiResponse? get deletePengajuanResponse => _deletePengajuanResponse;
  void deletePengajuan() async {
    if (_deletePengajuanResponse is ApiResponseLoading){
      return;
    }
    _deletePengajuanResponse = ApiResponseLoading();
    notifyListeners();
    _deletePengajuanResponse = await _repository.deletePengajuan(_id!);
    notifyListeners();
  }
  bool canDeletePengajuan() {
    // Ini berarti kita sedang enggak ada di proses edit
    if (_id == null){
      return false;
    }
    // Admin bisa ngedit pengajuan dengan bagaimanapun
    if (_user.isAdmin) {
      return true;
    }

    // Ketika kamu adalah user non admin

    return status == StatusPengajuan.menunggu;
  }

  bool canSubmit(){
    if (tipePengajuanError != null ||
        pemasokError != null ||
        groupError != null ||
        _listBarangTransaksiError != null
    ) {
      return false;
    }
    return true;
  }

  void onTanggalChange(DateTime newValue){
    tanggal = newValue;
    notifyListeners();
  }
  void onJamChange(TimeOfDay newValue){
    jam = newValue;
    notifyListeners();
  }

  void Function(String?)? get onTipePengajuanChange {
    if (_id == null){
      return _onTipePengajuanChange;
    }
    return null;
  }

  void _onTipePengajuanChange(String? newValue){
    if (newValue != null){
      isPemasukan = newValue == tipePengajuanList[0];
      notifyListeners();
    }
  }
  void setNewListBarang(List<BarangTransaksi> newBarang) {
    listBarangTransaksi = newBarang;
    notifyListeners();
  }

  void onEditBarangTransaksi({
    required BarangTransaksi newBarangTransaksi,
    required int index
  }){
    listBarangTransaksi[index] = newBarangTransaksi;
    notifyListeners();
  }

  void deleteBarang(BarangTransaksi oldBarang) {
    listBarangTransaksi.remove(oldBarang);
    notifyListeners();
  }

  bool get useDisabledButton{
    if (!_user.isAdmin && status == StatusPengajuan.diterima){
      return true;
    }
    return false;
  }

  String get submitButtonLabel {
    // berarti lagi ngebuat pengajuan baru
    if (_id == null){
      return 'Submit';
    }


    if (status == StatusPengajuan.menunggu && _user.isAdmin){
      return 'Terima';
    }


    return 'Simpan Perubahan';
  }

}