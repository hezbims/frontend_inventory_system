
import 'package:flutter/foundation.dart';

abstract class CommonUrl {
  static const _debugApiUrl = 'http://127.0.0.1:8000/api';
  static const _productionApiUrl = 'http://192.168.27.100:9999/api';
  static String get baseApiUrl{
    if (!kReleaseMode && kIsWeb){
      return _debugApiUrl;
    }
    return _productionApiUrl;
  }

  // TODO : Ganti sama env pusher_app_key
  static String get webSocketUrl {
    if (!kReleaseMode && kIsWeb){
      return 'ws://127.0.0.1:6001/app/0034c6855cd02144d9f7';
    }
    return 'ws://192.168.27.100:6001/app/0034c6855cd02144d9f7';
  }

}