import 'package:dependencies/web_socket_channel.dart';

class NotificationSocketClient {
  Stream newPengajuanNotification() {
    const url = 'ws://127.0.0.1:6001/app/pengajuan-baru-event';
    final wsChannel = WebSocketChannel.connect(Uri.parse(url));

    return wsChannel.stream;
  }
}