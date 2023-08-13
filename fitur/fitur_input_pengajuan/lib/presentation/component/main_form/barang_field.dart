import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:common/routes/routes.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/tambah_sesuatu_button.dart';
import 'package:fitur_input_pengajuan/presentation/provider/input_pengajuan_provider.dart';
import 'package:flutter/material.dart';

import 'barang_transaksi_card.dart';

class BarangField extends StatelessWidget {
  final List<BarangTransaksi> listBarangTransaksi;

  const BarangField({
    super.key,
    required this.listBarangTransaksi,
  });

  @override
  Widget build(BuildContext context) {
    final InputPengajuanProvider provider = Provider.of(context , listen : false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "List barang",
          style: labelStyle,
        ),

        ...buildCards(),

        const SizedBox(height: 12,),

        TambahSesuatuButton(
          label: "Tambah barang",
          onTap: (){
            Navigator.of(context).pushNamed(
              Routes.fiturInputListBarangRoute,
              arguments: provider
            );
          },
        ),
      ],
    );
  }

  List<Widget> buildCards(){
    final widgetList = <Widget>[];
    for (int i = 0 ; i < listBarangTransaksi.length ; i++){
      if (i > 0){
        widgetList.add(const SizedBox(height: 4,));
      }
      widgetList.add(BarangTransaksiCard(barangTransaksi: listBarangTransaksi[i]));
    }
    return widgetList;
  }
}
