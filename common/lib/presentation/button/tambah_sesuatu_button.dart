import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';

class TambahSesuatuButton extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const TambahSesuatuButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline , color: primaryColor,),

          const SizedBox(width: 4,),

          Text(
            label,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor
            ),
          )
        ],
      ),
    );
  }
}
