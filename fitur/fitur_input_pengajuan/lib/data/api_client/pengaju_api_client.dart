import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class PengajuApiClient {
  Future<Response> getPengaju(int isPemasok){
    final url = "${CommonUrl.baseUrl}/pengaju/get?is_pemasok=$isPemasok";

    return get(Uri.parse(url));
  }
}