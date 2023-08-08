import 'package:flutter/material.dart';

class CustomErrorBorder extends OutlineInputBorder {
  final double thickness;
  CustomErrorBorder({
    this.thickness = 1.0,
  }) : super(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: Colors.red,
      width: thickness,
    )
  );
}