import 'package:common/domain/model/barang.dart';
import 'package:flutter/material.dart';
import 'package:common/themes/custom_font_weight.dart';

class PreviewBarangCard extends StatelessWidget {
  final Barang barang;
  const PreviewBarangCard({
    super.key,
    required this.barang,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(barang.nama,),
            Text(
              "Current stock : ${barang.stockSekarang}",
              style: TextStyle(fontWeight: CustomFontWeight.light),
            )
          ],
        ),
      ),
    );
  }
}
