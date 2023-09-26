import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/component/common/transaksi_barang_bottom_sheet_setup.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:flutter/material.dart';

class BarangTransaksiCard extends StatelessWidget {
  final BarangTransaksi _barangTransaksi;
  final void Function(BarangTransaksi) _onEdit;
  const BarangTransaksiCard({
    super.key,
    required BarangTransaksi barangTransaksi,
    required void Function(BarangTransaksi) onEdit,
  }) : _onEdit = onEdit, _barangTransaksi = barangTransaksi;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainFormProvider>(context , listen: false);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _barangTransaksi.namaBarang,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Quantity : ${_barangTransaksi.quantity}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "Keterangan : ${_barangTransaksi.keterangan ?? "-"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w200
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () async {
                final newBarangTransaksi = await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return TransaksiBarangBottomSheetBuilder(
                      initialBarangTransaksi: _barangTransaksi,
                    );
                  }
                );

                if (newBarangTransaksi is BarangTransaksi){
                  _onEdit(newBarangTransaksi);
                }
              },
              icon: const Icon(Icons.edit),
            ),

            IconButton(
              onPressed: () =>
                provider.deleteBarang(_barangTransaksi),
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
