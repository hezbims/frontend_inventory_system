import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/file_picker.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvProvider extends ChangeNotifier {
  InputBarangByCsvProvider({
    required IBarangRepository repository,
  }) : _repository = repository;
  final IBarangRepository _repository;

  PlatformFile? _choosenFile;
  PlatformFile? get choosenFile => _choosenFile;
  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles();
    _choosenFile = pickedFile?.files.single;
    notifyListeners();
  }

  bool _overrideDataOnSubmit = false;
  bool get overrideDataOnSubmit => _overrideDataOnSubmit;
  void onChangeOverrideDataOnSubmit(bool? newValue) {
    if (newValue != null) {
      _overrideDataOnSubmit = newValue;
      notifyListeners();
    }
  }

  void Function()? get onSubmmit {
    if (_choosenFile == null || uploadByExcelResponse is ApiResponseLoading){
      return null;
    }
    return _submit;
  }

  ApiResponse? _uploadByExcelResponse;
  ApiResponse? get uploadByExcelResponse => _uploadByExcelResponse;
  void _submit() async {
    if (_uploadByExcelResponse is ApiResponseLoading) {
      return;
    }
    _uploadByExcelResponse = ApiResponseLoading();
    notifyListeners();

    final response = await _repository.uploadBarangByExcel(
        file: _choosenFile!,
        isUpsert: _overrideDataOnSubmit,
    );
    if (response is ApiResponseFailed){
      Fluttertoast.showToast(
        msg: response.error.toString(),
        timeInSecForIosWeb: 4
      );
    }
    _uploadByExcelResponse = response;
    notifyListeners();
  }
}