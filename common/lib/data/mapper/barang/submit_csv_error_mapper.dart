import 'dart:convert';

class SubmitCsvErrorMapper {
  Map<String , List<String>> mapError(String body){
    final jsonBody = jsonDecode(body);
    
    return jsonBody["errors"];
  }
}