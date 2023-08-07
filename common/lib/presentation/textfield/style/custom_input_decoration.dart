import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  final String? errorMessage;
  CustomInputDecoration({
    required this.errorMessage,
  }) : super(
    errorText: errorMessage,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 0.5,
          color: Colors.grey
        )
    ),
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
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}