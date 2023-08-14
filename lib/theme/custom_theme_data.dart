import 'package:common/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:stock_bu_fan/theme/custom_filled_button_theme.dart';
import 'package:stock_bu_fan/theme/custom_floating_action_button_theme.dart';
import 'package:stock_bu_fan/theme/custom_input_decoration_theme.dart';
import 'package:stock_bu_fan/theme/custom_search_bar_theme.dart';
import 'package:stock_bu_fan/theme/custom_text_theme.dart';

final customThemeData = ThemeData(
  useMaterial3: true,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple
    ),
  inputDecorationTheme: CustomInputDecorationTheme(),
  textTheme: CustomTextTheme.textTheme,
  filledButtonTheme: CustomFilledButtonTheme(),
  floatingActionButtonTheme: const CustomFloatingActionButtonTheme(),
  searchBarTheme: CustomSearchBarTheme(),
);