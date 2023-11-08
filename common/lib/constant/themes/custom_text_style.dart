import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:flutter/material.dart';

abstract class CustomTextStyle {
  /// Digunakan untuk font style nama barang di stock barang dan pemilihan barang
  static const headerStyle = TextStyle(
    fontWeight: CustomFontWeight.medium,
    fontSize: 18,
  );
}