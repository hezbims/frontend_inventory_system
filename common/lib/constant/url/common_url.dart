
import 'package:common/constant/url/env/i_env.dart';
import 'package:common/constant/url/env/local_env.dart';
import 'package:common/constant/url/env/production_env.dart';
import 'package:flutter/foundation.dart';

abstract class CommonUrl {
  static IEnv? __env;
  static IEnv get _env {
    if (__env == null){
      if (!kReleaseMode && kIsWeb){
        __env = LocalEnv();
      }
      else {
        __env = ProductionEnv();
      }
    }
    return __env!;
  }

  static String? _baseApiUrl;
  static String get baseApiUrl =>
    _baseApiUrl ??= 'http://${_env.serverHost}:${_env.serverPort}/api';

  static String? _webSocketUrl;
  static String get webSocketUrl =>
    _webSocketUrl ??= 'ws://${_env.serverHost}:${_env.websocketPort}/app/${_env.pusherAppKey}';

}