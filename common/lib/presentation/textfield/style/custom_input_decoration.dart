import 'package:common/presentation/textfield/style/border.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  final String? errorMessage;
  final String? placeholder;
  CustomInputDecoration({
    required this.errorMessage,
    this.placeholder,
  }) : super(
    label: placeholder != null ? Text(placeholder) : null,
    errorText: errorMessage,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        width: 0.5,
        color: Colors.grey,
      )
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: CustomErrorBorder(),
    focusedErrorBorder: CustomErrorBorder(
      thickness: 2
    ),
  );
}