import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/web_socket_channel.dart';

class NotificationSocketClient {
  final ITokenManager _tokenManager;
  NotificationSocketClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Stream newPengajuanNotification() {
    const url = 'ws://127.0.0.1:6001/app/pengajuan-baru-event';
    final wsChannel = WebSocketChannel.connect(Uri.parse(url));

    return wsChannel.stream;
  }
}