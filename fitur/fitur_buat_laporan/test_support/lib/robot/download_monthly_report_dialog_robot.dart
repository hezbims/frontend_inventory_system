import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common_test_support/extension/finder_extension.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DownloadMonthlyReportDialogRobot {
  final WidgetTester tester;
  DownloadMonthlyReportDialogRobot(this.tester);



  Future<void> changeYear(final String year) async {
    final yearFieldContainer = find.widgetWithText(CustomTextfield, "Year");
    final yearTextfield = find.descendant(of: yearFieldContainer, matching: find.byType(TextField));

    await tester.enterText(yearTextfield, year);
  }



  Future<void> changeMonth(final Month month) async {
    final monthFieldContainer = find.widgetWithText(CustomDropdownMenu<Month>, "Month");
    final monthDropdown = find.descendant(of: monthFieldContainer, matching: find.byType(DropdownButtonFormField<Month>));


    await tester.tap(monthDropdown);
    await tester.pumpAndSettle();


    final dropdownItemFinder = find.textCaseInsensitive(month.name).last;
    await tester.ensureVisible(dropdownItemFinder);
    // INI WAJIB BANGET DI PUMP SETELAH ensureVisible, AKU BERHARI-HARI BETULIN INI
    await tester.pump();


    expect(dropdownItemFinder.hitTestable(), findsOneWidget);
    await tester.tap(dropdownItemFinder);
    await tester.pumpAndSettle();
  }



  Future<void> downloadPdf() async {
    await tester.tap(find.text("PDF"));
    await tester.pump();
  }


}