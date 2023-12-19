import 'dart:async';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/web_socket_channel.dart';
import 'package:flutter/material.dart';

class WebSocketClient {
  static WebSocketChannel? _wsChannel;
  final _notificationStream = StreamController<bool>();

  final _user = GetIt.I.get<User>();

  Stream getStream(){
    _tryConnectWebsocket();
    return _notificationStream.stream;
  }

  void _tryConnectWebsocket() async {
    if (_isDisposed){
      return;
    }

    _wsChannel?.sink.close();
    _wsChannel = WebSocketChannel.connect(
      Uri.parse("${CommonUrl.webSocketUrl}/pengajuan/event"),
    );
    await _wsChannel!.ready;

    _wsChannel!.stream.listen(
        (event) {
          final eventValue = event.toString();
          try {
            if (eventValue == "Please Confirm") {
              _wsChannel!.sink.add("Ready");
              _notificationStream.add(true);
            }
          } catch (_){ debugPrint("Disposed"); }
        },
        onDone: (){
          Future.delayed(const Duration(seconds: 5) , _tryConnectWebsocket);
        },
        onError: (Object error, StackTrace stackTrace) {
          Future.delayed(const Duration(seconds: 5) , _tryConnectWebsocket);
        }
    );
    // NGIRIM JWT Token
    if (!_isDisposed) {
      _wsChannel!.sink.add(_user.token);
    }
  }

  bool _isDisposed = false;
  void dispose(){
    _isDisposed = true;
    _wsChannel?.sink.close();
    _notificationStream.close();
  }
}