import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class LihatPengajuanApiClient {
  Future<Response> getPengajuanPreview(int pageNumber){
    final url = "${CommonUrl.baseUrl}/pengajuan/get?page=$pageNumber";

    return get(Uri.parse(url));
  }
}