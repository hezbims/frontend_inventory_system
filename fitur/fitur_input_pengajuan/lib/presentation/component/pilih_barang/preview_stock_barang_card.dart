import 'package:common/domain/model/barang.dart';
import 'package:dependencies/google_fonts.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:common/themes/custom_font_weight.dart';

class PreviewStockBarangCard extends StatelessWidget {
  final Barang barang;
  const PreviewStockBarangCard({
    super.key,
    required this.barang,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PilihBarangProvider>(context , listen : false);
    return InkWell(
      onTap: () async {
        if (barang.stockSekarang > 0) {
          final result = await showModalBottomSheet(
              context: context,
              builder: (context) {
                return TransaksiBarangBottomSheet(currentBarang: barang);
              }
          );
          provider.quantityFocusNode.requestFocus();
          
          if (result is BarangTransaksi){
            provider.addNewBarangTransaksi(result);
          }
        }
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(barang.nama,),
              Text(
                "Current stock : ${barang.stockSekarang}",
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
