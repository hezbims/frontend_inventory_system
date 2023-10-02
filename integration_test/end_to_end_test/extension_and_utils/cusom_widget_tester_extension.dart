import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension CustomWidgetTesterExtension on WidgetTester {
  Future<void> typeTextField({
    required String textFieldLabel,
    required String input,
  }) async {
    final customColumnTextField = find.widgetWithText(Column, textFieldLabel);
    expect(customColumnTextField, findsOneWidget);

    final textField = find.descendant(
        of: customColumnTextField,
        matching: find.byType(TextField)
    );
    expect(textField, findsOneWidget);

    final scrollable = find.byType(ListView);
    await dragUntilVisible(textField, scrollable, const Offset(0, -50));
    await enterText(textField, input);
  }

  Future<void> chooseDropdown({
    required String dropdownLabel,
    required String input,
  }) async {
    final dropdownField = find.byType(DropdownButtonFormField<String>);
    expect(dropdownField, findsOneWidget);
    await tap(dropdownField);
    await pumpAndSettle();

    final dropdownItem = find.text(input).last;
    expect(dropdownItem, findsOneWidget);
    await tap(dropdownItem);
    await pump();
  }
}