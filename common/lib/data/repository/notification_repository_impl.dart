
import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:common/constant/url/common_url.dart';
import 'package:common/data/api_client/pengajuan_event_api_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/mapper/pengajuan/new_pengajuan_event_mapper.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:dependencies/web_socket_channel.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final _mapper = NewPengajuanEventMapper();
  final _apiClient = PengajuanEventApiClient();

  @override
  Stream newPengajuanNotification() {
    final wsChannel = WebSocketChannel.connect(
        Uri.parse(CommonUrl.webSocketUrl)
    );

    final User user = GetIt.I.get();
    final channelSubscribe = user.isAdmin ?
    "pengajuan-baru-channel" : "pengajuan-responded-${user.id}";

    wsChannel.sink.add(
      jsonEncode({
        "event": "pusher:subscribe",
        "data": {
          "channel": channelSubscribe
        }
      }),
    );

    return wsChannel.stream;
  }

  StreamController<int>? _streamController;
  HttpRequest? _httpRequest;

  @override
  Stream<int> getNewPengajuanEvent() {

    final url = "${CommonUrl.baseApiUrl}/pengajuan/event";
    final user = GetIt.I.get<User>();

    final headers = {
      "authorization" : "Bearer ${user.token}",
      "accept" : "text/event-stream",
      "Cache-Control" : "no-cache"
    };

    if (kIsWeb) { return _webSse(url , headers: headers); }
    else { return _mobileSse(url , headers: headers); }
  }

  Stream<int> _webSse(String url , {Map<String, String>? headers}){
    _streamController?.close();
    _streamController = StreamController();

    _httpRequest = HttpRequest();

    _httpRequest?.open("GET", url);
    headers?.forEach((key, value) {
      _httpRequest?.setRequestHeader(key, value);
    });

    int progress = 0;
    _httpRequest?.onProgress.listen((event) {
      final textStream = _httpRequest?.responseText!.substring(progress);
      debugPrint("Ada event! : $textStream");
      progress += textStream?.length ?? 0;

      if (textStream != null) {
        final parsedData = _mapper.parseData(textStream);
        if (parsedData != null) {
          _streamController?.add(parsedData);
        }
      }
    });

    _httpRequest?.onError.listen((event) {
      _httpRequest?.abort();
      _streamController?.addError(
        _httpRequest?.responseText ?? _httpRequest?.status ?? 'Unknown error',
      );
    });
    _httpRequest?.send();
    return _streamController!.stream;
  }

  Stream<int> _mobileSse(String url , {Map<String , String>? headers}) {
    _streamController?.close();
    _streamController = StreamController();

    final request = Request(
        'GET', Uri.parse(url));
    headers?.forEach((key, value) {
      request.headers[key] = value;
    });
    final response = Client().send(request);
    response.asStream().listen((event) {
      event.stream.listen((value) {
        final textStream = utf8.decode(value);
        final parsedData = _mapper.parseData(textStream);
        if (parsedData != null) {
          _streamController?.add(parsedData);
        }
      });
    });

    return _streamController!.stream;
  }

  @override
  Future<ApiResponse> acknowledgeNewPengajuan(){
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.acknowledgePengajuan()
    );
  }

  @override
  void dispose(){
    _httpRequest?.abort();
    _streamController?.close();
  }
}