import 'dart:convert';

class SubmitCsvErrorMapper {
  Map<String , List<String>> mapError(String body){
    final jsonBody = jsonDecode(body);

    final result = <String , List<String>>{};

    final errors = jsonBody["errors"];
    for (var kvpError in errors.entries){
      result[kvpError.key] = kvpError.value.cast<String>();
    }
    return result;
  }
}