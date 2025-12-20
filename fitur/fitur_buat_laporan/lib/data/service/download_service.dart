import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:universal_html/html.dart' as html;

import '../../domain/service/i_download_service.dart';
import 'package:dependencies/file_picker.dart';
import 'package:flutter/foundation.dart';

class DownloadService implements IDownloadService {

  @override
  Future<void> downloadFile(Uint8List fileContent, String fileName) async {
    if (!kIsWeb) {
      final path = await FilePicker.platform.getDirectoryPath();
      if (path == null || path == "/"){
        return;
      }

      final filePath = "$path/$fileName";
      await File(filePath).writeAsBytes(fileContent);

      return;
    }

    final blob = html.Blob([fileContent]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html
        .AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = fileName;
    html.document.body!.children.add(anchor);

    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}