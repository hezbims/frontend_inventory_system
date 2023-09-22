import 'dart:math';

import 'package:flutter/material.dart';

extension MediaQueryDataExtension on MediaQueryData {
  double get maxHorizontalPadding {
    return max(24, (size.width - 720) / 2);
  }
}