import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:common/presentation/button/tambah_sesuatu_button.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/pages/pilih_barang_screen.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';

import 'barang_transaksi_card.dart';

class ListBarangFormField extends StatelessWidget {
  final List<BarangTransaksi> listBarangTransaksi;

  const ListBarangFormField({
    super.key,
    required this.listBarangTransaksi,
  });

  @override
  Widget build(BuildContext context) {
    final MainFormProvider provider = Provider.of(context , listen : false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "List barang",
          style: labelStyle,
        ),

        const SizedBox(height: 12,),

        TambahSesuatuButton(
          label: "Tambah barang",
          onTap: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PilihBarangScreen(
                  arg: MainFormToPilihBarangArg(
                    initialList: provider.listBarangTransaksi,
                    isPemasukan: provider.isPemasukan!,
                  ),
                  onPopDone: (listBarangTransaksi) =>
                    provider.setNewListBarang(listBarangTransaksi),
                ),
              ),
            );
          },
        ),

        ...buildCards(provider),


      ],
    );
  }

  List<Widget> buildCards(MainFormProvider provider){
    final widgetList = <Widget>[];
    for (int i = 0 ; i < listBarangTransaksi.length ; i++){
      if (i > 0){
        widgetList.add(const SizedBox(height: 4,));
      }
      widgetList.add(
        BarangTransaksiCard(
          barangTransaksi: listBarangTransaksi[i],
          onEdit: (newBarangTransaksi){
            provider.onEditBarangTransaksi(
              newBarangTransaksi: newBarangTransaksi,
              index: i
            );
          },
        )
      );
    }
    return widgetList;
  }
}
