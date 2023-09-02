import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:dependencies/http.dart';

class UserApiClient {
  Future<Response> getUser() async {
    final url = "${CommonUrl.baseUrl}/get-current-user";

    return get(
        Uri.parse(url),
        headers: await TokenManager.getTokenizedHeader()
    );
  }
}