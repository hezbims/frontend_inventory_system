import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_page_controller.dart';

class LihatStockBarangTestPage extends TestPageController {
  final FilterDrawer filterDrawer;

  LihatStockBarangTestPage({required super.tester})
    : filterDrawer = FilterDrawer(tester: tester);

  Future<void> clickFilter() async {
    await tester.tap(find.byIcon(Icons.filter_alt));
    await tester.pumpAndSettle();
  }
}

class FilterDrawer extends TestPageController {
  FilterDrawer({required super.tester});
}