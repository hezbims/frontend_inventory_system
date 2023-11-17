import 'package:dependencies/file_picker.dart';
import 'package:flutter/material.dart';

class InputBarangByCsvProvider extends ChangeNotifier {
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
    if (_choosenFile == null){
      return null;
    }
    return _submit;
  }
  void _submit(){

  }
}