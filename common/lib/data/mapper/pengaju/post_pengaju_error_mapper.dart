import 'dart:convert';

import 'package:common/constant/json_field/pengaju_field.dart';

class PostPengajuErrorMapper {
  String getErrorFromBody(String body){
    final jsonBody = jsonDecode(body);
    final errorMap = jsonBody['errors'] as Map<String , dynamic>;
    return errorMap[PengajuField.nama][0];
  }
}