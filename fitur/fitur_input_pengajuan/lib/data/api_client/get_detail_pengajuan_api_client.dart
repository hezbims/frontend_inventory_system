import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class GetDetailPengajuanApiClient {
  Future<Response> getDetailPengajuan(int id){
    final url = "${CommonUrl.baseUrl}/pengajuan/get/$id";

    return get(Uri.parse(url));
  }
}