import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:flutter/material.dart';

class PengajuanCard extends StatelessWidget {
  final PengajuanPreview pengajuan;
  final void Function() onTap;
  const PengajuanCard({
    super.key,
    required this.pengajuan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text("Tipe : ${pengajuan.tipe}"),
                ),

                Text(pengajuan.kodeTransaksi),
              ],
            ),

            const SizedBox(height: 10,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(pengajuan.namaPengaju)
                ),

                OutlinedButton(
                  onPressed: onTap,
                  child: const Text("Lihat Detail"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
