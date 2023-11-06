abstract class ITokenManager {
  Future<void> setToken(String token);
  Future<void> clearToken();
  Future<Map<String , String>> getLocalStorageTokenizedHeader();
  Map<String , String> getCurrentSessionTokenizedHeader();
}