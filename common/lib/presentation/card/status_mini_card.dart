import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:flutter/material.dart';

class StatusMiniCard extends StatelessWidget {
  final StatusPengajuan status;
  const StatusMiniCard({super.key , required this.status,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: status.getContainerColor(),
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
            color: status.getTextColor()
        ),
      ),
    );
  }
}
