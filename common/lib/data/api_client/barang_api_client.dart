import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class BarangApiClient {
  Future<Response> getAllBarang(){
    const getBarangUrl = "${CommonUrl.baseUrl}/barang/all";

    return get(Uri.parse(getBarangUrl));
  }
}