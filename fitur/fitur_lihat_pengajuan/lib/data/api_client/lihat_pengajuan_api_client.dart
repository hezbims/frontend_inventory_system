import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class LihatPengajuanApiClient {
  Future<Response> getPengajuanPreview({
    required int pageNumber,
    required String keyword,
  }){
    final url = "${CommonUrl.baseUrl}/pengajuan/get?page=$pageNumber&keyword=$keyword";

    return get(Uri.parse(url));
  }
}