// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/file_picker.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:flutter/foundation.dart';

class InputBarangByCsvProvider extends ChangeNotifier {
  InputBarangByCsvProvider({
    required IBarangRepository repository,
  }) : _repository = repository;
  final IBarangRepository _repository;

  PlatformFile? _choosenFile;
  PlatformFile? get choosenFile => _choosenFile;
  void pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["csv"]
    );
    _choosenFile = pickedFile?.files.single;
    notifyListeners();
  }

  bool _isHovering = false;
  bool get isHovering => _isHovering;
  void onHover(){
    _isHovering = true;
    print("On Hover");
    notifyListeners();
  }
  void onLeaveHover(){
    _isHovering = false;
    print("Leave hover");
    notifyListeners();
  }

  void handleDropFile(File file) async {
    if (kIsWeb){
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      await reader.onLoad.first;
      _choosenFile = PlatformFile(
        name: file.name,
        size: file.size,
        bytes: reader.result as Uint8List
      );
      _isHovering = false;
      notifyListeners();
    }
  }

  void onDropInvalid(String? _){
    if (kIsWeb){
      Fluttertoast.showToast(
          msg: "Tolong pilih file dengan format '.csv'",
          timeInSecForIosWeb: 4
      );
      _isHovering = false;
      notifyListeners();
    }
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
      final errs = response.error as Map<String , List<String>>;
      Fluttertoast.showToast(
        msg: response.error.toString(),
        timeInSecForIosWeb: 4
      );
    }
    _uploadByExcelResponse = response;
    notifyListeners();
  }

  void downloadTemplate() async {
    _repository.downloadCsvTemplate();
  }
}