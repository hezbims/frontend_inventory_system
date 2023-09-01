import 'package:dependencies/http.dart';
import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
class SettingAkunApiClient {
  Future<Response> logout() async {
    final url = "${CommonUrl.baseUrl}/logout";

    return delete(
      Uri.parse(url),
      headers: await TokenManager.getTokenizedHeader()
    );
  }
}