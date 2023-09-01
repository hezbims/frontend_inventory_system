import 'package:flutter/material.dart';

class SettingAkunItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function() onTap;

  const SettingAkunItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 12,),

          Text(
            label,
          ),
        ],
      ),
    );
  }
}
