
import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:dependencies/web_socket_channel.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final _wsChannel = WebSocketChannel.connect(
      Uri.parse(CommonUrl.webSocketUrl)
  );

  @override
  Stream newPengajuanNotification() {
    final User user = GetIt.I.get();


    final channelSubscribe = user.isAdmin ?
    "pengajuan-baru-channel" : "pengajuan-responded-${user.id}";

    _wsChannel.sink.add(
      jsonEncode({
        "event": "pusher:subscribe",
        "data": {
          "channel": channelSubscribe
        }
      }),
    );

    return _wsChannel.stream;
  }

  @override
  Future<Stream<String>> testSse() async {
    const url = "http://localhost:3000/test-sse";
    final headers = {
      'accpet' : "text/event-stream",
      "Cache-Control" :  "no-cache"
    };
    if (kIsWeb) { return _webSse(url , headers: headers); }
    else { return _mobileSse(url , headers: headers); }
  }

  Stream<String> _webSse(String path , {Map<String, String>? headers}){
    final httpRequest = HttpRequest();
    final streamController = StreamController<String>();

    httpRequest.open("GET", path);
    headers?.forEach((key, value) {
      httpRequest.setRequestHeader(key, value);
    });

    int progress = 0;
    httpRequest.addEventListener('progress', (event) {
      final data = httpRequest.responseText!.substring(progress);
      progress += data.length;
      streamController.add(data);
    });
    httpRequest.addEventListener('loadend', (event) {
      httpRequest.abort();
      streamController.close();
    });
    httpRequest.addEventListener('error', (event) {
      streamController.addError(
        httpRequest.responseText ?? httpRequest.status ?? 'err',
      );
    });
    httpRequest.send();
    return streamController.stream;
  }

  Future<Stream<String>> _mobileSse(String path , {Map<String , String>? headers}) async {
    final request = Request(
        'GET', Uri.parse(path));
    headers?.forEach((key, value) {
      request.headers[key] = value;
    });
    debugPrint('Mau manggil SSE');
    final response = await Client().send(request);
    debugPrint("Response status code : ${response.statusCode}");


    return response.stream.map((data) => utf8.decode(data));
  }
}