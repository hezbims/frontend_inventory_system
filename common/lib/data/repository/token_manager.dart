import 'package:dependencies/shared_preference.dart';

abstract class TokenManager {
  static const _tokenKey = 'token';
  static SharedPreferences? _pref;
  static Future<Map<String , String>> getTokenizedHeader() async {
    _pref ??= await SharedPreferences.getInstance();

    final token = _pref!.get(_tokenKey);

    return {
      'Authorization' : "Bearer $token",
      'Accept' : 'application/json',
    };
  }

  // TODO : pasttin token di set sehabis login dan pas ngedapetin current user di repository
  static Future<void> setToken(String token) async {
    _pref ??= await SharedPreferences.getInstance();

    await _pref!.setString(_tokenKey, token);
  }

  static Future<void> clearToken() async {
    _pref ??= await SharedPreferences.getInstance();

    await _pref!.remove(_tokenKey);
  }
}