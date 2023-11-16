import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/themes/custom_color.dart';
import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:common/presentation/card/status_mini_card.dart';
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getContainerColorByStatus(pengajuan.status),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.15),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 4),
            color: Color(0x40000000),
            blurRadius: 4,
            spreadRadius: 0
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  pengajuan.namaPengaju,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: CustomFontWeight.medium,
                  ),
                )
              ),

              StatusMiniCard(status: pengajuan.status),
            ],
          ),

          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pengajuan.kodeTransaksi,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  Text(
                    '(${pengajuan.username})',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),


              OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 13,
                  )
                ),
                child: const Text(
                  "Lihat Detail",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Color _getContainerColorByStatus(StatusPengajuan status){
    switch (status){
      case StatusPengajuan.diterima:
        return CustomColor.goodLight;
      case StatusPengajuan.menunggu:
        return CustomColor.warningLight;
      case StatusPengajuan.ditolak:
        return CustomColor.dangerLight;
      default:
        throw Exception('Tipe enum tidak ditemukan');
    }
  }
}
