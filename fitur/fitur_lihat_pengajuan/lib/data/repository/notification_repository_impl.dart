import 'dart:async';
import 'dart:convert';

import 'package:common/constant/url/common_url.dart';
import 'package:common/data/api_client/pengajuan_event_api_client.dart';
import 'package:common/data/api_client/sse_client/mobile_sse_client.dart';
import 'package:common/data/api_client/sse_client/web_sse_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/web_socket_channel.dart';
import 'package:fitur_lihat_pengajuan/data/mapper/new_pengajuan_event_mapper.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final _mapper = NewPengajuanEventMapper();
  final _apiClient = PengajuanEventApiClient();
  final _mobileSseClient = MobileSseClient();
  final _webSseClient = WebSseClient();

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

  final _streamController = StreamController<int>();

  @override
  Stream<int> getNewPengajuanEvent() {
    final url = "${CommonUrl.baseApiUrl}/pengajuan/event";
    final user = GetIt.I.get<User>();

    final headers = {
      "authorization" : "Bearer ${user.token}",
      "accept" : "text/event-stream",
      "Cache-Control" : "no-cache"
    };
    final sse = kIsWeb ?
        _webSseClient.getSse(url , headers: headers) :
        _mobileSseClient.getSse(url , headers: headers);
    sse.listen((eventText) async {
      final decodedValue = _mapper.parseData(eventText);
      if (decodedValue != null){
        final ackResponse = await acknowledgeNewPengajuan();
        if (ackResponse is ApiResponseSuccess) {
          _streamController.add(decodedValue);
        }
      }
    });

    return _streamController.stream;
  }

  Future<ApiResponse> acknowledgeNewPengajuan(){
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.acknowledgePengajuan()
    );
  }

  @override
  void dispose(){
    _streamController.close();
    _webSseClient.dispose();
    _mobileSseClient.dispose();
  }
}