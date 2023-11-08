import 'package:common/constant/themes/custom_text_style.dart';
import 'package:common/constant/themes/status_colors.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:flutter/material.dart';

class PreviewStockBarangCard extends StatelessWidget {
  final BarangPreview barang;
  final void Function() onTap;
  const PreviewStockBarangCard({
    super.key,
    required this.barang,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: normalGreyLightColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(4 , 4),
              blurRadius: 15,
              spreadRadius: -3,
              color: Color(0x1a000000),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 0.2),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(barang.nama, style: CustomTextStyle.headerStyle,),
            
            Text(
              "Current stock : ${barang.currentStock}",
              style: const TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            
            const SizedBox(height: 12,),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text("Rak :\n${barang.rak}")),
                Expanded(child: Text("Kategori :\n${barang.kategori}")),
                Expanded(child: Text("Kode :\n${barang.kodeBarang}")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
