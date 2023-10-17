// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterWaitUntilDisappear on WidgetTester {
  Future<void> waitUntilDisappear(
    Finder finder,{
    Duration timeout = const Duration(seconds: 20),
  }) async {
    final end = binding.clock.now().add(timeout);

    do {
      if (binding.clock.now().isAfter(end)) {
        throw Exception('Timed out waiting for $finder');
      }
      await pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 100));

    } while (finder.evaluate().length == 1);
  }
}