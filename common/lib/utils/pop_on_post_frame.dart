import 'package:flutter/material.dart';

extension PopOnPostFrame on BuildContext {
  void popOnPostFrame(Object? result){
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Navigator.of(this).pop(result),
    );

  }
}