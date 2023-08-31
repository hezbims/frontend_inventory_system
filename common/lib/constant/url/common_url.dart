import 'package:flutter/foundation.dart';

abstract class CommonUrl {
  static const _debugUrl = 'http://127.0.0.1:8000/api';
  static const _productionUrl = 'http://192.168.152.100:9999/api';
  static String get baseUrl{
    if (kReleaseMode){
      return _productionUrl;
    }
    return _debugUrl;
  }
}