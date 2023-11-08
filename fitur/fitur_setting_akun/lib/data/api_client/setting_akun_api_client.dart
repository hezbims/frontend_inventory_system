import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:common/constant/url/common_url.dart';
class SettingAkunApiClient {
  final ITokenManager _tokenManager = GetIt.I.get();
  Future<Response> logout() async {
    final url = "${CommonUrl.baseApiUrl}/logout";

    return delete(
      Uri.parse(url),
      headers: _tokenManager.getCurrentSessionTokenizedHeader()
    );
  }
}