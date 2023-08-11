import 'package:common/domain/model/barang.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/provider/input_pengajuan_provider.dart';
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
    final provider = Provider.of<InputPengajuanProvider>(context , listen: false);
    return InkWell(
      onTap: () async {
        if (barang.stockSekarang > 0) {
          final BarangTransaksi? data;
          data = await showModalBottomSheet(
              context: context,
              builder: (context) {
                return TransaksiBarangBottomSheet(currentBarang: barang);
              }
          );
          if (data != null){
            provider.addNewBarang(data);
          }
        }
      },
      child: Card(
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
      ),
    );
  }
}
