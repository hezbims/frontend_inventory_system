
import 'package:fitur_lihat_pengajuan/data/api_client/web_socket_client.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final WebSocketClient _webSocketClient = WebSocketClient();

  @override
  void observePengajuanDataVersion({
    required void Function(int pengajuanDataVersion) onEvent,
    required void Function() onDisconnected,
  }) {
    _webSocketClient.tryConnectWebsocket(onEvent, onDisconnected);
  }

  @override
  void dispose(){
    _webSocketClient.dispose();
  }
}