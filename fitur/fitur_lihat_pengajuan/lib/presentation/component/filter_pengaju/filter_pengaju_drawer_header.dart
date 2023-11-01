import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:flutter/material.dart';

class FilterPengajuDrawerHeader extends StatelessWidget {
  const FilterPengajuDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 24,),
        Expanded(
          child: Text(
            'Filter Pengaju',
            style: TextStyle(
              fontWeight: CustomFontWeight.semiBold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_forward)
        ),
      ],
    );
  }
}
