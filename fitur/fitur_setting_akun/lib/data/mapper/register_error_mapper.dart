import 'dart:convert';
import 'package:common/constant/json_field/user_field.dart';
import 'package:flutter/material.dart';

class RegisterErrorMapper {
  Map<String , String?> getErrorFromBody(String body){
    debugPrint(body);
    final jsonBody = jsonDecode(body);

    // TODO : pasttiin ngeformatnya bener kalo ada null,
    return {
      UserField.username : jsonBody['errors'][UserField.username]?[0],
      UserField.password : jsonBody['errors'][UserField.password]?[0],
      UserField.isAdmin : jsonBody['errors'][UserField.isAdmin]?[0],
    };
  }
}