import 'dart:convert';
import 'package:common/constant/json_field/user_field.dart';
import 'package:flutter/material.dart';

class RegisterErrorMapper {
  Map<String , String?> getErrorFromBody(String body){
    debugPrint(body);
    final jsonBody = jsonDecode(body);

    // TODO : pasttiin ngeformatnya bener kalo ada null,
    return {
      UserField.username : jsonBody['data'][UserField.username]?[0],
      UserField.password : jsonBody['data'][UserField.password]?[0],
    };
  }
}