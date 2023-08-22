import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class GetPengajuApiClient {
  Future<Response> getPengaju(bool isPemasok){
    final url = "${CommonUrl.baseUrl}/pengaju/get?is_pemasok=${isPemasok ? 1 : 0}";

    return get(Uri.parse(url));
  }
}