import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';

class CustomFilledButtonTheme extends FilledButtonThemeData {
  CustomFilledButtonTheme() : super(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states){
            if (states.contains(WidgetState.disabled)){
              return Colors.grey;
            }
            return primaryColor;
          }
        ),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 24,
            )
        ),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
      )
  );
}