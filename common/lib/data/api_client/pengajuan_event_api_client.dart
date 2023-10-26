import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:dependencies/http.dart';
import 'package:dependencies/web_socket_channel.dart';

class PengajuanEventApiClient {
  final _tokenManager = TokenManagerImpl();
  Stream newPengajuanNotification() {
    const url = 'ws://127.0.0.1:6001/app/pengajuan-baru-event';
    final wsChannel = WebSocketChannel.connect(Uri.parse(url));

    return wsChannel.stream;
  }

  Future<Response> acknowledgePengajuan() async {
    final url = "${CommonUrl.baseApiUrl}/pengajuan/ack";
    return post(
      Uri.parse(url),
      headers: await _tokenManager.getTokenizedHeader(),
    );
  }
}