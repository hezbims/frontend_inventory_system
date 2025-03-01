import 'dart:convert';
import 'dart:io';

import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';

class LoginApiClient {
  Future<Response> login(PostLoginDto data) async {
    final url = "${CommonUrl.baseApiUrl}/login";
    return post(
      Uri.parse(url),
      body: jsonEncode({
        'username' : data.username,
        'password' : data.password,
      }),
      headers: {
        HttpHeaders.contentTypeHeader : 'application/json'
      }
    );
  }
}