import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_autentikasi/domain/model/post_login_dto.dart';

class AuthApiClient {
  Future<Response> login(PostLoginDto data) async {
    const url = "${CommonUrl.baseUrl}/login";
    return post(
      Uri.parse(url),
      body: {
        'username' : data.username,
        'password' : data.password,
      },
    );
  }
}