abstract class ITokenManager {
  static Future<void> setToken(String token);
  static Future<Map<String , String>> getTokenizedHeader();
}