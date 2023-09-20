import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';

class GetDetailPengajuanApiClient {
  final ITokenManager _tokenManager;
  GetDetailPengajuanApiClient({
    ITokenManager? tokenManager
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> getDetailPengajuan(int id) async {
    final url = "${CommonUrl.baseApiUrl}/pengajuan/get/$id";

    return get(
      Uri.parse(url),
      headers: await _tokenManager.getTokenizedHeader(),
    );
  }
}