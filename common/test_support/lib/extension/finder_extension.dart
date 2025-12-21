import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension FinderExtension on CommonFinders {
  Finder textCaseInsensitive(String text, {bool includeRichText = true,}){
    return find.byWidgetPredicate((w){
      if (w is Text){
        return w.data?.toLowerCase() == text.toLowerCase();
      }
      else if (includeRichText && w is RichText){
        return w.text.toPlainText().toLowerCase() == text.toLowerCase();
      }
      else {
        return false;
      }
    },
      description: 'Text containing "$text" (case-insensitive)',
    );
  }
}