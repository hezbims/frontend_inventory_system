import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  /// For scrolling lazy list until an item is found
  Future<void> scrollUpAndDownUntilVisible({
    required WidgetTester tester,
    required Finder scrollable,
    required Finder target,
    double scrollAmount = 200,
    int maxScrolls = 10,
  }) async {
    // 1️⃣ Try scrolling UP first
    for (int i = 0; i < maxScrolls; i++) {
      if (target.tryEvaluate()){
        await tester.ensureVisible(target);
        return;
      }

      await tester.drag(scrollable, Offset(0, scrollAmount));
      await tester.pump();
    }

    // 2️⃣ Then scroll DOWN
    for (int i = 0; i < maxScrolls; i++) {
      if (target.tryEvaluate()) {
        await tester.ensureVisible(target);
        return;
      }

      await tester.drag(scrollable, Offset(0, -scrollAmount));
      await tester.pump();
    }

    // 3️⃣ Fail explicitly if not found
    fail('Widget not found after scrolling up and down $target');
  }
}