import 'package:dependencies/file_saver.dart';
import 'package:flutter/foundation.dart';

class CsvTemplateSaver {
  void saveCsvFile(String body) async {
    var bytes = Uint8List.fromList(body.codeUnits);
    FileSaver.instance.saveFile(
      name: "template_input_barang.csv",
      bytes: bytes
    );
  }
}