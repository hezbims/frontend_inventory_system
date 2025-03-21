import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:dependencies/collection.dart';
import 'package:fitur_lihat_stock_barang/domain/model/preview_barang.dart';
import 'package:flutter/material.dart';

class ListStockBarangTable extends StatelessWidget {
  final List<PreviewBarang> listBarang;
  final int startIndex;
  final List<double> columnWidths = [60, 400, 135, 138, 155, 112];
  final void Function(int) onClickEdit;

  ListStockBarangTable({
    required int pageNumber,
    required this.listBarang,
    required this.onClickEdit,
    super.key,
  }) : startIndex = (pageNumber - 1) * 50 + 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: const TableBorder(
          horizontalInside: BorderSide(width: 0.1)
        ),
        columnWidths: {
          for (int i = 0 ; i < columnWidths.length ; i++)
            i : FixedColumnWidth(columnWidths[i])
        },
        children: [
          buildHeader(),
          ...listBarang.mapIndexed((index, barang) =>
            buildDataRow(index, barang),
          )
        ],
      ),
    );
  }

  TableRow buildHeader(){
    final textAlignments = [TextAlign.center, TextAlign.left, TextAlign.center, TextAlign.center, TextAlign.center, TextAlign.center];
    final labels = ["No", "Name", "Location", "Quantity", "Status", "Action"];

    return TableRow(
      children: [
        for (int i = 0 ; i < 6 ; i++)
          TableCell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: MyColors.primary1,
              child: Text(
                labels[i],
                textAlign: textAlignments[i],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200
                ),
              ),
            ),
          ),
      ]
    );
  }

  TableRow buildDataRow(int index, PreviewBarang barang){
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white :MyColors.background1,
      ),
      children: [
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("${index + startIndex}", textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(barang.name))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(barang.location, textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(barang.quantity, textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: getBarangStatus(barang.status))),
        TableCell(child: SizedBox(
          width: 26,
          child: Center(
            child: FilledButton(
              onPressed: (){
                onClickEdit(barang.id);
              },
              style: FilledButton.styleFrom(
                backgroundColor: MyColors.primary4,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)
                ),
              ),
              child: const Text("Edit", style: TextStyle(fontWeight: FontWeight.w300),),
            ),
          ),
        ))
      ]
    );
  }

  Widget getBarangStatus(BarangStockStatus status){
    final String label;
    final Color color;
    switch(status){
      case BarangStockStatus.runOut:
        label = "Run Out";
        color = MyColors.danger1;
        break;
      case BarangStockStatus.shortage:
        label = "Shortage";
        color = MyColors.warning1;
        break;
      case BarangStockStatus.ok:
        label = "Ok";
        color = MyColors.ok1;
        break;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 4,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}