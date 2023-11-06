import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';

class BarangApiClient {
  final ITokenManager _tokenManager;
  BarangApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? GetIt.I.get();

  Future<Response> getBarang(int pageNumber , String keyword) async {
    final getBarangUrl = "${CommonUrl.baseApiUrl}/barang/all?page=$pageNumber&keyword=$keyword";
    return get(
      Uri.parse(getBarangUrl),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }

  Future<Response> getDetailBarang({required int id}) async {
    final url = "${CommonUrl.baseApiUrl}/barang/detail/$id";
    return get(
      Uri.parse(url),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }
}