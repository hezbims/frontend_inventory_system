import 'package:flutter/material.dart';

class CustomSearchBarTheme extends SearchBarThemeData {
  CustomSearchBarTheme() : super(
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      )
    ),
    elevation: const MaterialStatePropertyAll(0),
    backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
  );
}