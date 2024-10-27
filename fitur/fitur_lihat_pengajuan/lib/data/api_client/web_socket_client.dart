
import 'dart:async';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/web_socket_channel.dart';

class WebSocketClient {
  static WebSocketChannel? _wsChannel;

  final User _user = GetIt.I.get();
  StreamSubscription<dynamic>? _notificationSubscription;

  void tryConnectWebsocket(
    void Function(int pengajuanTableVersion) onEvent,
    void Function() onDisconnected,
  ) async {

    _wsChannel?.sink.close();

    _wsChannel = WebSocketChannel.connect(
      Uri.parse("${CommonUrl.webSocketUrl}/pengajuan/event"),
    );

    await _wsChannel!.ready;

    try {
      _wsChannel?.sink.add(_user.token);
    // ignore: empty_catches
    } catch (e){}

    _notificationSubscription = _wsChannel!.stream.listen(
        (event) {
          onEvent(int.parse(event.toString()));
        },
        onDone: (){
          if (_wsChannel?.closeCode != _disposedStatusCode){
            onDisconnected();
          }
        },
        cancelOnError: true,
    );
  }

  void dispose(){
    _wsChannel?.sink.close(_disposedStatusCode);
    _notificationSubscription?.cancel();
  }

  static const int _disposedStatusCode = 4500;
}