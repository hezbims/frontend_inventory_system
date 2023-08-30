import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class TestApiClient {
  Future<Response> resetDatabase(){
    const url = "${CommonUrl.baseUrl}/reset-database";
    return delete(Uri.parse(url));
  }

  Future<Response> seedBarang(){
    const url = "${CommonUrl.baseUrl}/seed-barang-large";
    return get(Uri.parse(url));
  }
}