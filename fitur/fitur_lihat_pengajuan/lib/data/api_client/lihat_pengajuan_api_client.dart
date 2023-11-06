import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';

class LihatPengajuanApiClient {
  final ITokenManager _tokenManager;
  LihatPengajuanApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> getPengajuanPreview({
    required int pageNumber,
    required String keyword,
    required int? idPengaju,
  }) async {
    final url = "${CommonUrl.baseApiUrl}/pengajuan/get?"
        "page=$pageNumber&"
        "keyword=$keyword&"
        "id_pengaju=${idPengaju ?? ''}";

    return get(
      Uri.parse(url),
      headers: await _tokenManager.getLocalStorageTokenizedHeader(),
    );
  }
}