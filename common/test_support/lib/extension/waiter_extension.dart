import 'package:flutter_test/flutter_test.dart';

extension WaiterExtension on WidgetTester {
  Future<void> waitUntilDisappear(
      Finder finder,{
        Duration timeout = const Duration(seconds: 5),
      }) async {
    final end = binding.clock.now().add(timeout);

    while (finder.evaluate().isNotEmpty){
      if (binding.clock.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }
      await pumpAndSettle(Duration(milliseconds: 200));
    }
  }

  Future<void> waitUntilAppearExactlyOnce(
      Finder finder,{
        Duration timeout = const Duration(seconds: 5),
      }) async {
    final end = binding.clock.now().add(timeout);

    while (finder.evaluate().length != 1){
      if (binding.clock.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }
      await pumpAndSettle(Duration(milliseconds: 200));
    }
  }
}