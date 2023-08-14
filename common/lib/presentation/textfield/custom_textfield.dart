import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final TextInputType inputType;
  final void Function(String)? onChanged;
  final int minLines;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.errorText,
    this.inputType = TextInputType.text,
    this.onChanged,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle,
        ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(errorText: errorText),
          onChanged: onChanged,
          minLines: minLines,
          maxLines: minLines,
        )
      ],
    );
  }
}
