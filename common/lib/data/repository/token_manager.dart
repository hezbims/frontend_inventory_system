import 'dart:io';

import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/shared_preference.dart';

class TokenManagerImpl implements ITokenManager {
  TokenManagerImpl._privateConstructor();
  static final TokenManagerImpl _instance = TokenManagerImpl._privateConstructor();
  factory TokenManagerImpl(){
    return _instance;
  }

  final _tokenKey = 'token';
  SharedPreferences? _pref;
  @override
  Future<Map<String , String>> getLocalStorageTokenizedHeader() async {
    _pref ??= await SharedPreferences.getInstance();
    final token = _pref!.get(_tokenKey);

    return _constructTokenizedHeader(token.toString());
  }

  @override
  Future<void> setToken(String token) async {
    _pref ??= await SharedPreferences.getInstance();

    await _pref!.setString(_tokenKey, token);
  }

  @override
  Future<void> clearToken() async {
    _pref ??= await SharedPreferences.getInstance();

    await _pref!.remove(_tokenKey);
  }

  @override
  Map<String, String> getCurrentSessionTokenizedHeader() {
    return _constructTokenizedHeader(GetIt.I.get<User>().token);
  }

  Map<String , String> _constructTokenizedHeader(String token){
    return {
      HttpHeaders.authorizationHeader : "Bearer $token",
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader : 'application/json',
    };
  }
}