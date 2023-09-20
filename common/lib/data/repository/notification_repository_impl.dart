
import 'dart:convert';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/web_socket_channel.dart';

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
}