import 'package:dependencies/flutter_dotenv.dart';

abstract class CommonUrl {
  static String? _baseApiUrl;
  static String get baseApiUrl =>
    _baseApiUrl ??= dotenv.get('API_URL');

  static String? _webSocketUrl;
  static String get webSocketUrl =>
    _webSocketUrl ??= dotenv.get('WEBSOCKET_URL');

}