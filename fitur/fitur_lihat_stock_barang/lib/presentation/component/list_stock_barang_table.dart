import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/color/my_colors.dart';
import 'package:dependencies/collection.dart';
import 'package:flutter/material.dart';

class ListStockBarangTable extends StatelessWidget {
  final List<Barang> listBarang;
  final int startIndex;
  final List<double> columnWidths = [60, 400, 135, 138, 155, 112];

  ListStockBarangTable({
    required int pageNumber,
    required this.listBarang,
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

  TableRow buildDataRow(int index, Barang barang){
    return TableRow(
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white :MyColors.background1,
      ),
      children: [
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("${index + startIndex}", textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(barang.nama))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("R${barang.nomorRak}-${barang.nomorLaci}-${barang.nomorKolom}", textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text("${barang.stockSekarang} ${barang.uom}", textAlign: TextAlign.center,))),
        TableCell(child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(getBarangStatus(barang), textAlign: TextAlign.center,))),
        TableCell(child: SizedBox(
          width: 26,
          child: Center(
            child: FilledButton(
              onPressed: (){},
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

  String getBarangStatus(Barang barang){
    if (barang.stockSekarang <= 0) {
      return "Run Out";
    } else if (barang.stockSekarang <= barang.minStock) {
      return "Shortage";
    }
    return "Ok";
  }
}