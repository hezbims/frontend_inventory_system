//test_driver/foo_test.dart
import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: onScreenshot
  );
}

Future<bool> onScreenshot(
    String screenshotName,
    List<int> screenshotBytes,
    [Map<String, Object?>? x]
) async {
  final image = await File(screenshotName).create(recursive: true);
  image.writeAsBytesSync(screenshotBytes);
  return true;
}