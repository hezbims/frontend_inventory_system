import 'dart:convert';

abstract class PaginationChecker {
  static bool hasNext(String body){
    final jsonBody = jsonDecode(body);
    if (jsonBody['links']['next'] == null){
      return false;
    }
    else {
      return true;
    }
  }
}