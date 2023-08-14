import 'package:common/themes/theme.dart';
import 'package:flutter/material.dart';

class CustomFilledButtonTheme extends FilledButtonThemeData {
  CustomFilledButtonTheme() : super(
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(primaryColor),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 24,
            )
        ),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
      )
  );
}