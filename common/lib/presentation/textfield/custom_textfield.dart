import 'package:common/presentation/textfield/style/custom_input_decoration.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorMessage;
  final TextInputType inputType;
  final void Function(String)? onChanged;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.errorMessage,
    this.inputType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: CustomInputDecoration(
            errorMessage: errorMessage,
          ),
          onChanged: onChanged,
        )
      ],
    );
  }
}
