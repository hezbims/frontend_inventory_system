import 'package:common/domain/repository/i_token_manager.dart';
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
  Future<Map<String , String>> getTokenizedHeader() async {
    _pref ??= await SharedPreferences.getInstance();

    final token = _pref!.get(_tokenKey);

    return {
      'Authorization' : "Bearer $token",
      'Accept' : 'application/json',
      'Content-Type' : 'application/json',
    };
  }

  // TODO : pasttin token di set sehabis login dan pas ngedapetin current user di repository
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
}