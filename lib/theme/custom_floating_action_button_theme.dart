import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';

class CustomFloatingActionButtonTheme extends FloatingActionButtonThemeData {
  const CustomFloatingActionButtonTheme() : super(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    shape: const CircleBorder(),
  );
}