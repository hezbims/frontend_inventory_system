import 'package:dependencies/shared_preference.dart';
import 'package:flutter/material.dart';

abstract class TokenManager {
  static const _tokenKey = 'token';
  static SharedPreferences? _pref;
  static Future<Map<String , String>> getTokenizedHeader() async {
    _pref ??= await SharedPreferences.getInstance();

    final token = _pref!.get(_tokenKey);

    debugPrint("Token manager : $token}");
    return {
      'Authorization' : "Bearer $token",
      'Accept' : 'application/json',
    };
  }

  static Future<void> setToken(String token) async {
    _pref ??= await SharedPreferences.getInstance();

    await _pref!.setString(_tokenKey, token);
  }
}