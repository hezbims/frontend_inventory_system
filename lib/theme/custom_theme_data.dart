import 'package:common/constant/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/theme/custom_filled_button_theme.dart';
import 'package:stock_bu_fan/theme/custom_floating_action_button_theme.dart';
import 'package:stock_bu_fan/theme/custom_input_decoration_theme.dart';
import 'package:stock_bu_fan/theme/custom_search_bar_theme.dart';

final customThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple
    ),
  inputDecorationTheme: CustomInputDecorationTheme(),
  fontFamily: 'Inter',
  filledButtonTheme: CustomFilledButtonTheme(),
  floatingActionButtonTheme: const CustomFloatingActionButtonTheme(),
  searchBarTheme: CustomSearchBarTheme(),
);