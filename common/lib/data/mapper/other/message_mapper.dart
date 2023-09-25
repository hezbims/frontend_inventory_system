import 'dart:convert';

abstract class DefaultMessageMapper  {
  static String getMessageFromBody(String jsonString){
    try {
      final json = jsonDecode(jsonString);
      return json['message'];
    } catch (_) {
      return jsonString;
    }
  }
}