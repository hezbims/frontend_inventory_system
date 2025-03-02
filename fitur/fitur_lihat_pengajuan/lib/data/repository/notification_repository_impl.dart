
import 'package:common/data/api_client/inventory_system_http_client.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_pengajuan/data/api_client/web_socket_client.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final WebSocketClient _webSocketClient = WebSocketClient();
  final InventorySystemHttpClient _httpClient = GetIt.I.get();

  @override
  void observePengajuanDataVersion({
    required void Function(int pengajuanDataVersion) onEvent,
    required void Function() onDisconnected,
  }) {
    _webSocketClient.tryConnectWebsocket(onEvent, onDisconnected);
  }


  @override
  Stream<int> getSseTransaction() {
    return _httpClient.doEventStreamRequest(endpoint: "pengajuan/event")
        .takeWhile((event) => event.name == "get-user-transaction-version")
        .map((event) => int.parse(event.data));
  }


  @override
  void dispose(){
    _webSocketClient.dispose();
  }
}