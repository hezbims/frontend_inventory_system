import 'package:fitur_buat_laporan/presentation/style/text_style.dart';
import 'package:pdf/widgets.dart';

class LaporanTableHeader extends TableRow {
  LaporanTableHeader(): super(
      children: [
        Text("NO" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("ITEM NO" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("ITEM DESCRIPTION" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("LOCATION" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("UOM" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("STD STOCK" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("LAST MONTH STOCK" , style: textHeaderStyle , textAlign: TextAlign.center),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("STOCK" , style: textHeaderStyle),
            Table(
              border: TableBorder.all(width: 0.5),
              columnWidths: {
                0 : const FlexColumnWidth(1),
                1 : const FlexColumnWidth(1),
                2 : const FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  children: [
                    Text("IN" , style: textHeaderStyle , textAlign: TextAlign.center),
                    Text("OUT" , style: textHeaderStyle , textAlign: TextAlign.center),
                    Text("ACTUAL" , style: textHeaderStyle , textAlign: TextAlign.center),
                  ]
                ),
              ],
            ),
          ],
        ),
        Text("UNIT PRICE" , style: textHeaderStyle , textAlign: TextAlign.center),
        Text("AMOUNT" , style: textHeaderStyle , textAlign: TextAlign.center),
      ]
  );
}