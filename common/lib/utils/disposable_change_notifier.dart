import 'package:flutter/material.dart';

abstract class DisposableChangeNotifier extends ChangeNotifier {
  bool _canUseResource = true;
  bool get canUseResource => _canUseResource;

  @override
  void dispose(){
    _canUseResource = false;
    super.dispose();
  }
}