import 'package:dependencies/google_fonts.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:common/themes/custom_font_weight.dart';

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
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(barang.nama,)),
                  Text(
                    "Kode : ${barang.kodeBarang}" ,
                    style: GoogleFonts.inter(
                      fontWeight: CustomFontWeight.light,
                    ),
                  ),
                ],
              ),
              Text(
                "Current stock : ${barang.currentStock}",
                style: GoogleFonts.inter(
                  fontWeight: CustomFontWeight.light,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
