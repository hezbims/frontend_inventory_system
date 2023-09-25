import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';

class PengajuApiClient {
  final ITokenManager _tokenManager;
  PengajuApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> getPengaju(bool isPemasok){
    final url = "${CommonUrl.baseApiUrl}/pengaju/get?is_pemasok=${isPemasok ? 1 : 0}";

    return get(Uri.parse(url));
  }

  Future<Response> createPengaju(String body) async {
    final url = "${CommonUrl.baseApiUrl}/pengaju/add";
    return post(
      Uri.parse(url),
      headers: await _tokenManager.getTokenizedHeader(),
      body: body,
    );
  }
}