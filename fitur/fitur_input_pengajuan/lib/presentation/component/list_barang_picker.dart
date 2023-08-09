import 'package:common/domain/model/barang.dart';
import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:common/themes/theme.dart';
import 'package:fitur_input_pengajuan/presentation/component/preview_barang_card.dart';
import 'package:flutter/material.dart';

class ListBarangPicker extends StatelessWidget {
  final List<Barang> listBarang;

  const ListBarangPicker({
    super.key,
    required this.listBarang,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "List barang",
          style: labelStyle,
        ),

        ListView.separated(
          itemBuilder: (context , index){
            return PreviewBarangCard(barang: listBarang[index]);
          },
          separatorBuilder: (context , index){
            return const SizedBox(height: 10,);
          },
          itemCount: listBarang.length,
        ),
        const Row(
          children: [
            Icon(Icons.add_circle_outline , color: primaryColor,),
            
            SizedBox(width: 4,),
            
            Text(
              "Tambah barang",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor
              ),
            )
          ],
        )
      ],
    );
  }
}
