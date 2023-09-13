import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:common/constant/themes/theme_color.dart';
import 'package:common/presentation/card/status_mini_card.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:common/constant/themes/status_colors.dart';
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
      color: pengajuan.status.getContainerColor(),
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

                StatusMiniCard(status: pengajuan.status),
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

                InkWell(
                  borderRadius: BorderRadius.circular(12),
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
}
