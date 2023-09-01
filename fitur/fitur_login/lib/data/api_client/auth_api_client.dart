import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_login/domain/model/post_login_dto.dart';

class AuthApiClient {
  Future<Response> login(PostLoginDto data) async {
    final url = "${CommonUrl.baseUrl}/login";
    return post(
      Uri.parse(url),
      body: {
        'username' : data.username,
        'password' : data.password,
      },
    );
  }

  Future<Response> getNewToken() async {
    final url = "${CommonUrl.baseUrl}/get-current-user";

    return get(
      Uri.parse(url),
      headers: await TokenManager.getTokenizedHeader()
    );
  }
}