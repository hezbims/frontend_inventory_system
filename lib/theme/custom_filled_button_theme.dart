import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';

class CustomFilledButtonTheme extends FilledButtonThemeData {
  CustomFilledButtonTheme() : super(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states){
            if (states.contains(MaterialState.disabled)){
              return Colors.grey;
            }
            return primaryColor;
          }
        ),
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