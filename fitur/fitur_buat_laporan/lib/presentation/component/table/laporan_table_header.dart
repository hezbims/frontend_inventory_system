import 'package:fitur_buat_laporan/presentation/style/text_style.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class LaporanTableHeader extends TableRow {
  LaporanTableHeader() : super(
    children: [
      _cell("NO"),
      _cell("ITEM NO"),
      _cell("ITEM DESCRIPTION"),
      _cell("LOCATION"),
      _cell("UOM"),
      _cell("STD STOCK"),
      _cell("LAST MONTH STOCK"),

      SizedBox(
        height: _cellHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: _cellHeight / 2,
              child: Text(
                "STOCK", style:
                textHeaderStyle,
                textAlign: TextAlign.center
              ),
              alignment: Alignment.center,
            ),
            Container(
              height: _cellHeight / 2,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(width: 0.5))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: _subHeaderCell("IN")),
                  Container(height: double.infinity, width: 0.5, color: PdfColors.black),
                  Expanded(flex: 1, child: _subHeaderCell("OUT")),
                  Container(height: double.infinity, width: 0.5, color: PdfColors.black),
                  Expanded(flex: 2, child: _subHeaderCell("ACTUAL")),
                ],
              )
            ),
          ],
        ),
      ),

      _cell("UNIT PRICE"),
      _cell("AMOUNT"),
    ],
  );

  static Widget _cell(String text) => Container(
    height: _cellHeight,
    alignment: Alignment.center,
    child: Text(text, style: textHeaderStyle, textAlign: TextAlign.center),
  );

  static Widget _subHeaderCell(String text) => Text(
    text,
    style: textHeaderStyle,
    textAlign: TextAlign.center
  );

  static const _cellHeight = 30.0;
}