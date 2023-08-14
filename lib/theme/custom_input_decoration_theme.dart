import 'package:common/presentation/textfield/style/border/custom_enabled_border.dart';
import 'package:common/presentation/textfield/style/border/custom_error_border.dart';
import 'package:common/presentation/textfield/style/border/custom_focused_border.dart';
import 'package:flutter/material.dart';

class CustomInputDecorationTheme extends InputDecorationTheme {
  CustomInputDecorationTheme() : super(
    focusedBorder: CustomFocusedBorder(),
    enabledBorder: CustomEnabledBorder(),
    errorBorder: CustomErrorBorder(),
    focusedErrorBorder: CustomErrorBorder(thickness: 2),
  );
}