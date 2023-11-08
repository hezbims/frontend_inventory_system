import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButtonTheme extends OutlinedButtonThemeData {
  CustomOutlinedButtonTheme() : super(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: primaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      foregroundColor: primaryColor,
    )
  );
}