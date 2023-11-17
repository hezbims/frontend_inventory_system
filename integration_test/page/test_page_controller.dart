import 'package:flutter_test/flutter_test.dart';

abstract class TestPageController {
  final WidgetTester tester;
  TestPageController({required this.tester});
}