import 'package:flutter/material.dart';

class SettingAkunItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const SettingAkunItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),

        const SizedBox(width: 12,),

        Text(
          label,
        ),
      ],
    );
  }
}
