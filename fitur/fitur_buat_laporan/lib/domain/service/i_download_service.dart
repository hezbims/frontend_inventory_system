import 'dart:typed_data';

abstract class IDownloadService {
  Future<void> downloadFile(Uint8List fileContent, String fileName);
}