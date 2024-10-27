import 'package:flutter/material.dart';

class CustomSearchBarTheme extends SearchBarThemeData {
  CustomSearchBarTheme() : super(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      )
    ),
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
  );
}