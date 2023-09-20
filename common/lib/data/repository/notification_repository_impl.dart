
import 'dart:convert';

import 'package:common/data/api_client/notification_socket_client.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:dependencies/web_socket_channel.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationSocketClient _apiClient;
  NotificationRepositoryImpl({
    NotificationSocketClient? apiClient,
  }) : _apiClient = apiClient ?? NotificationSocketClient();
  @override
  Stream newPengajuanNotification() {
    // TODO : Ganti sama env pusher_app_key
    const url = 'ws://127.0.0.1:6001/app/0034c6855cd02144d9f7';
    final wsChannel = WebSocketChannel.connect(Uri.parse(url));
    wsChannel.sink.add(
      jsonEncode({
        "event": "pusher:subscribe",
        "data": {
          "channel": "pengajuan-baru-channel"
        }
      }),
  );

    return wsChannel.stream;
  }
}