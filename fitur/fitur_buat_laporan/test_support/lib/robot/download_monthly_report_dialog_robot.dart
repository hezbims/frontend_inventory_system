import 'package:common/presentation/textfield/custom_dropdown_menu.dart';
import 'package:common/presentation/textfield/custom_textfield.dart';
import 'package:common_test_support/extension/finder_extension.dart';
import 'package:common_test_support/extension/widget_tester_extension.dart';
import 'package:fitur_buat_laporan/domain/model/month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DownloadMonthlyReportDialogRobot {
  final WidgetTester tester;
  DownloadMonthlyReportDialogRobot(this.tester);

  Finder get _yearFormFieldFinder => find.widgetWithText(CustomTextfield, "Year");
  Finder get _monthDropdownFinder => find.widgetWithText(CustomDropdownMenu<Month>, "Month");

  Future<void> changeYear(final String year) async {
    final yearTextfield = find.descendant(of: _yearFormFieldFinder, matching: find.byType(TextField));

    await tester.enterText(yearTextfield, year);
  }



  Future<void> changeMonth(final Month month) async {
    final monthDropdown = find.descendant(of: _monthDropdownFinder, matching: find.byType(DropdownButtonFormField<Month>));


    await tester.tap(monthDropdown);
    await tester.pumpAndSettle();


    final monthListContainer = find.byType(Scrollable).last;
    final dropdownItemFinder = find.descendant(
      of: monthListContainer,
      matching: find.textCaseInsensitive(month.name, includeRichText: false),
    );
    // harus scroll up and down karena dropdown itemnya sifatnya lazy loading
    await tester.scrollUpAndDownUntilVisible(
      tester: tester,
      scrollable: monthListContainer,
      target: dropdownItemFinder,
    );
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

  Future<void> downloadCsv() async {
    await tester.tap(find.text("CSV"));
    await tester.pump();
  }

  Finder get _downloadCsvButtonFinder => find.widgetWithIcon(FilledButton, Icons.table_chart_outlined);
  Finder get _downloadPdfButtonFinder => find.widgetWithIcon(FilledButton, Icons.picture_as_pdf_outlined);

  FilledButton get _downloadCsvButton =>
      tester.widget<FilledButton>(_downloadCsvButtonFinder);
  FilledButton get _downloadPdfButton =>
      tester.widget<FilledButton>(_downloadPdfButtonFinder);

  void expectDownloadPdfButtonEnabled() =>
      expect(_downloadPdfButton.onPressed, isNotNull);

  void expectDownloadCsvButtonEnabled() =>
      expect(_downloadCsvButton.onPressed, isNotNull);

  void expectDownloadPdfButtonDisabled() =>
      expect(_downloadPdfButton.onPressed, isNull);

  void expectDownloadCSVButtonDisabled() =>
      expect(_downloadCsvButton.onPressed, isNull);

  void expectDownloadPdfButtonHasDownloadingIndicator() =>
    expect(find.descendant(
        of: _downloadPdfButtonFinder,
        matching: find.byType(CircularProgressIndicator)), findsOneWidget);

  void expectDownloadCsvButtonHasDownloadingIndicator() =>
      expect(find.descendant(
          of: _downloadCsvButtonFinder,
          matching: find.byType(CircularProgressIndicator)), findsOneWidget);



  void expectYear(int year) {
    expect(
      find.descendant(
        of: _yearFormFieldFinder,
        matching: find.text(year.toString())),
      findsOneWidget
    );
  }


  void expectMonth(Month month){
    expect(
      find.descendant(
        of: _monthDropdownFinder,
        matching: find.textCaseInsensitive(month.name, includeRichText: false)),
      findsOneWidget
    );
  }
}