import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final Pengaju group;
  const GroupCard({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        Navigator.of(context).pop(group);
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                group.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
