import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/google_fonts.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_barang/transaksi_barang_bottom_sheet.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:flutter/material.dart';
import 'package:common/themes/custom_font_weight.dart';

class PreviewStockBarangCard extends StatelessWidget {
  final BarangPreview barang;
  const PreviewStockBarangCard({
    super.key,
    required this.barang,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PilihBarangProvider>(context , listen : false);
    return InkWell(
      onTap: () async {
        if (barang.currentStock == 0 &&
            !provider.isPemasukan) {
          Fluttertoast.showToast(msg: "Barang sudah habis!",);
          return;
        }
        if (provider.thisBarangAlreadyTaken(barang)) {
          Fluttertoast.showToast(msg: "Barang ini sudah pernah anda ambil!",);
          return;
        }

        final result = await showModalBottomSheet(
            context: context,
            builder: (context) {
              return TransaksiBarangBottomSheet(
                currentBarang: barang,
                isPemasukan: provider.isPemasukan,
              );
            }
        );
        provider.searchBarangFocusNode.requestFocus();

        if (result is BarangTransaksi) {
          provider.addNewBarangTransaksi(result);
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
