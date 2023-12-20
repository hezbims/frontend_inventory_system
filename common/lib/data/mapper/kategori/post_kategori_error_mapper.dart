import 'dart:convert';

import 'package:flutter/material.dart';

class PostKategoriErrorMapper {
  String getErrorFromBody(String body){
    debugPrint("Kategori error body : $body");
    final jsonBody = jsonDecode(body);
    final errorMap = jsonBody['errors'] as Map<String , dynamic>;
    return errorMap['nama']?[0];
  }
}