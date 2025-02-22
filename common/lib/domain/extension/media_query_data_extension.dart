import 'dart:math';

import 'package:common/constant/themes/custom_sizing.dart';
import 'package:flutter/material.dart';

extension MediaQueryDataExtension on MediaQueryData {
  double get phoneWidthLandscapePadding {
    return max(24, (size.width - CustomSizing.phoneLandscapeWidthWithPadding) / 2);
  }
  double get phoneWidthPotraitPadding {
    return max(24 , (size.width - CustomSizing.phonePotraitWidthWithPadding) / 2);
  }
  double get phoneHeightLandscapePadding {
    return max(24 , (size.height - CustomSizing.phonePotraitWidthWithPadding) / 2);
  }
  double get phoneHeightPotraitPadding {
    return max(24 , (size.height - CustomSizing.phoneLandscapeWidthWithPadding) / 2);
  }
  double get maxDrawerWidth {
    return min(288 , size.width * 4 / 5);
  }
  EdgeInsets get desktopPadding {
    return EdgeInsets.symmetric(
        horizontal: max(24 , (size.width - 1000) / 2)
    );
  }
}