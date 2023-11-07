import 'dart:math';

import 'package:flutter/material.dart';

extension MediaQueryDataExtension on MediaQueryData {
  double get phoneLandscapePadding {
    return max(24, (size.width - 720) / 2);
  }
  double get phonePotraitPadding {
    return max(24 , (size.width - 312) / 2);
  }
  double get maxDrawerWidth {
    return min(288 , size.width * 4 / 5);
  }
}