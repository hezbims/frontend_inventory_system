import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class DropDownPageChooser extends StatelessWidget {
  final String label;
  final String? value;
  final String? errorMessage;
  final void Function() onTap;
  const DropDownPageChooser({
    super.key,
    required this.label,
    required this.value,
    required this.errorMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label , style: labelStyle,),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              errorText: errorMessage,
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: Text(value ?? ""),
          ),
        ),
      ],
    );
  }
}
