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
}