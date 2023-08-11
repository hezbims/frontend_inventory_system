import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:common/routes/routes.dart';
import 'package:common/themes/theme.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
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

        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(
              Routes.fiturInputListBarangRoute,
              arguments: provider
            );
          },

          child: const Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
          ),
        )
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
