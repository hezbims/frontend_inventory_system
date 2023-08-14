import 'package:dependencies/provider.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/input_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class BarangTransaksiCard extends StatelessWidget {
  final BarangTransaksi barangTransaksi;
  const BarangTransaksiCard({
    super.key,
    required this.barangTransaksi,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InputPengajuanProvider>(context , listen: false);
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
                    barangTransaksi.barang.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Quantity : ${barangTransaksi.quantity}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "Keterangan : ${barangTransaksi.keterangan.isEmpty ? "-" : barangTransaksi.keterangan}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w200
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () =>
                provider.deleteBarang(barangTransaksi),
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
