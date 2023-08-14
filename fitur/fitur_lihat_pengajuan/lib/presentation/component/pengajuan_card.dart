import 'package:common/domain/model/pengajuan.dart';
import 'package:common/routes/routes.dart';
import 'package:flutter/material.dart';

class PengajuanCard extends StatelessWidget {
  final Pengajuan pengajuan;
  const PengajuanCard({
    super.key,
    required this.pengajuan,
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
                  child: Text(pengajuan.nama),
                ),

                Text(pengajuan.tanggal),
              ],
            ),

            const SizedBox(height: 10,),

            Text("Tipe : ${pengajuan.tipe}"),

            const SizedBox(height: 10,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("Group : ${pengajuan.group.namaGroup}")
                ),

                OutlinedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                      Routes.fiturInputDataPengajuanRoute,
                      arguments: pengajuan,
                    );
                  },
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
