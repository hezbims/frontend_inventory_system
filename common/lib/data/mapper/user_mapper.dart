import 'dart:convert';

import 'package:common/domain/model/user.dart';

class UserMapper {
  User getUserFromBody(String body){
    final jsonBody = jsonDecode(body);

    return User(
      token:jsonBody['token']
    );
  }
}