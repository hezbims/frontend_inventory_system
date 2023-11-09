import 'package:flutter/material.dart';

abstract class DisposableChangeNotifier extends ChangeNotifier {
  bool _canUseResource = true;
  /// Menandakan apakah resource sudah di-dispose atau belum.
  /// Kalau sudah pernah didispose maka akan mereturn false
  bool get canUseResource => _canUseResource;

  @override
  void dispose(){
    _canUseResource = false;
    super.dispose();
  }
}