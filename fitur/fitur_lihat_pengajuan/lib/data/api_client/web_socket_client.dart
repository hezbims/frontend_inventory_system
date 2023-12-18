import 'dart:async';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/web_socket_channel.dart';
import 'package:flutter/material.dart';

class WebSocketClient {
  WebSocketChannel? _wsChannel;
  final _notificationStream = StreamController<bool>();

  final _user = GetIt.I.get<User>();

  Stream getStream(){
    if (_wsChannel == null) {
      _tryConnectWebsocket();
    }

    return _notificationStream.stream;
  }

  void _tryConnectWebsocket(){
    debugPrint("TRY CONNECT WEBSOCKET");
    _wsChannel = WebSocketChannel.connect(
      Uri.parse("${CommonUrl.webSocketUrl}/pengajuan/event"),
    );
    _wsChannel!.stream.listen(
        (event) {

          _wsChannel!.sink.add(_user.username);
          // acknowledge
          _wsChannel!.sink.done
              .whenComplete(() => _notificationStream.add(true));
        } ,
        onDone: (){
          Future.delayed(const Duration(seconds: 5) , _tryConnectWebsocket);
              
        },
        onError: (Object error, StackTrace stackTrace) {
          Future.delayed(const Duration(seconds: 5) , _tryConnectWebsocket);
        }
    );
    if (_wsChannel!.closeCode == null) {
      // NGIRIM JWT Token
      _wsChannel!.sink.add(_user.token);
    }
  }

  void dispose(){
    _wsChannel!.sink.close();
    _notificationStream.close();
  }
}