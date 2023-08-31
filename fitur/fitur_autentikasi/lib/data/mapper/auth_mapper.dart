import 'dart:convert';

import 'package:flutter/material.dart';

class AuthMapper {
  String getTokenFromBody(String body){
    debugPrint("body : $body");
    final jsonBody = jsonDecode(body);

    return jsonBody['token'];
  }
}