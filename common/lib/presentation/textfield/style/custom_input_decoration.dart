import 'package:common/presentation/textfield/style/border/custom_error_border.dart';
import 'package:common/presentation/textfield/style/border/custom_enabled_border.dart';
import 'package:common/presentation/textfield/style/border/custom_focused_border.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration({
    required super.errorText,
    super.suffixIcon,
  }) : super(
    enabledBorder: CustomEnabledBorder(),
    focusedBorder: CustomFocusedBorder(),
    errorBorder: CustomErrorBorder(),
    focusedErrorBorder: CustomErrorBorder(
      thickness: 2
    ),
  );
}