import 'dart:convert';
import 'dart:io';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';

class InventorySystemHttpClient {

  final _httpClient = Client();

  Future<Response> doRequest({
    required final HttpMethod method,
    required final String endpoint,
    final Map<String, String>? headers,
    final Map<String, Object>? body,
  }) async {
    final Map<String, String> currentHeaders = {
      HttpHeaders.authorizationHeader: "Bearer ${GetIt.I.get<User>().token}",
      HttpHeaders.acceptHeader: "application/json",
    };
    if (method != HttpMethod.get) {
      currentHeaders[HttpHeaders.contentTypeHeader] = "application/json";
    }

    headers?.forEach((key, value){
      currentHeaders[key] = value;
    });

    final url = Uri.parse("${CommonUrl.baseApiUrl}/$endpoint");
    final jsonString = jsonEncode(body);
    return switch(method){
      HttpMethod.post => _httpClient.post(url, headers: currentHeaders, body: jsonString),
      HttpMethod.delete => _httpClient.delete(url, headers: currentHeaders, body: jsonString),
      HttpMethod.get => _httpClient.get(url, headers: currentHeaders),
      HttpMethod.put => _httpClient.put(url, headers: currentHeaders, body: jsonString),
      HttpMethod.patch => _httpClient.patch(url, headers: currentHeaders, body: jsonString),
    };
  }

  Stream<SseEvent> doEventStreamRequest({
    required final String endpoint,
    final HttpMethod method = HttpMethod.get,
    final Map<String, String>? headers,
  }) async* {
    final Map<String, String> currentHeaders = {
      HttpHeaders.authorizationHeader: "Bearer ${GetIt.I.get<User>().token}",
      HttpHeaders.acceptHeader: "text/event-stream",
    };
    headers?.forEach((key, value){
      currentHeaders[key] = value;
    });

    final url = Uri.parse("${CommonUrl.baseApiUrl}/$endpoint");
    final methodString = switch(method){
      HttpMethod.get => "GET",
      HttpMethod.put => "PUT",
      HttpMethod.delete => "DELETE",
      HttpMethod.post => "POST",
      HttpMethod.patch => "PATCH",
    };

    final request = Request(methodString, url);
    currentHeaders.forEach((key, value){
      request.headers[key] = value;
    });
    
    final response = await _httpClient.send(request);
    final stream = response.stream.map((byte) => utf8.decoder.convert(byte));
    await for (String result in stream) {
      List<String> events = result.split("\n\n");
      String name = "";
      String data = "";
      String id = "";
      String retry = "";
      for (final String eventType in events){
        if (eventType.startsWith("data:")){
          data = eventType.split(":").last.trim();
        }
        else if (eventType.startsWith("id:")){
          id = eventType.split(":").last.trim();
        }
        else if (eventType.startsWith("retry:")){
          retry = eventType.split(":").last.trim();
        }
        else if (eventType.startsWith("event:")){
          name = eventType.split(":").last.trim();
        }
      }
      yield SseEvent(name: name, data: data, id: id, retry: retry);
    }
  }
}

class SseEvent {
  final String name;
  final String data;
  final String id;
  final String retry;
  SseEvent({
    required this.name,
    required this.data,
    required this.id,
    required this.retry,
  });
}

enum HttpMethod {
  post, get, put, delete, patch;
}