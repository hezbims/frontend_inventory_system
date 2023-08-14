import 'package:flutter/material.dart';

class CustomEnabledBorder extends OutlineInputBorder {
  CustomEnabledBorder() : super(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      width: 0.5,
      color: Colors.grey,
    ),
  );
}