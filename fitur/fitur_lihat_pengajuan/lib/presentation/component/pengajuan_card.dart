import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:common/constant/themes/theme_color.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/styles.dart';
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
      color: getCardColorFrom(pengajuan.status),
      elevation: 0,
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

                buildStatusMiniCard(pengajuan.status),
              ],
            ),
            Text(
              pengajuan.kodeTransaksi,
              style: TextStyle(
                fontWeight: CustomFontWeight.light,
                fontSize: 10,
              ),
            ),

            const SizedBox(height: 10,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pengajuan.tipe == "Pengeluaran" ? "Group" : "Nama Pemasok",
                        style: smallText,
                      ),

                      Text(
                        pengajuan.namaPengaju,
                        style: smallText
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5 , color: primaryColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 2),
                    child: Text(
                      "Lihat Detail",
                      style: smallText.copyWith(color: primaryColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getCardColorFrom(StatusPengajuan status){
    switch (status){
      case StatusPengajuan.diterima:
        return const Color(0x4061FF00);
      case StatusPengajuan.menunggu:
        return const Color(0x40FFC700);
      case StatusPengajuan.ditolak:
        return const Color(0x40FF0000);
    }
  }

  Widget buildStatusMiniCard(StatusPengajuan status){
    late Widget text;
    late Color containerColor;

    switch (status) {
      case StatusPengajuan.diterima:
        text = const Text(
          'diterima',
          style: TextStyle(
            color: Color(0xFF0D6705),
            fontSize: 10,
          ),
        );
        containerColor = const Color(0x4014FF00);
        break;
      case StatusPengajuan.menunggu:
        text = const Text(
          'menunggu',
          style: TextStyle(
            color: Color(0xFF644E00),
            fontSize: 10,
          ),
        );
        containerColor = const Color(0x40FFC700);
        break;
      case StatusPengajuan.ditolak:
        text = const Text(
          'ditolak',
          style: TextStyle(
            color: Color(0xFF670505),
            fontSize: 10,
          ),
        );
        containerColor = const Color(0x40FF0000);
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4
      ),
      child: text,
    );
  }
}
