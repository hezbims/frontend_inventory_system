import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/constant/themes/custom_color.dart';
import 'package:flutter/material.dart';

class StatusMiniCard extends StatelessWidget {
  final StatusPengajuan status;
  const StatusMiniCard({super.key , required this.status,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _getContainerColorByStatus(status),
          borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4
      ),
      child: Text(
        status.name,
        style: TextStyle(
            fontSize: 10,
            color: _getTextColorByStatus(status),
        ),
      ),
    );
  }

  Color _getContainerColorByStatus(StatusPengajuan status){
    switch (status){
      case StatusPengajuan.diterima:
        return CustomColor.goodMedium;
      case StatusPengajuan.menunggu:
        return CustomColor.warningMedium;
      case StatusPengajuan.ditolak:
        return CustomColor.dangerMedium;
      default:
        throw Exception('Tipe enum tidak ditemukan');
    }
  }

  Color _getTextColorByStatus(StatusPengajuan status){
    switch (status){
      case StatusPengajuan.diterima:
        return CustomColor.goodHeavy;
      case StatusPengajuan.menunggu:
        return CustomColor.warningHeavy;
      case StatusPengajuan.ditolak:
        return CustomColor.dangerHeavy;
      default:
        throw Exception('Tipe enum tidak ditemukan');
    }
  }
}
