import 'dart:convert';


class AuthMapper {
  String getTokenFromBody(String body){
    final jsonBody = jsonDecode(body);

    return jsonBody['token'];
  }
}