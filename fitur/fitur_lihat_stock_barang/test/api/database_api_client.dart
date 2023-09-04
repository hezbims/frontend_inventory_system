import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class DatabaseApiClient {
  Future<Response> resetDatabase(){
    final url = "${CommonUrl.baseUrl}/reset-database";
    return delete(Uri.parse(url));
  }

  Future<Response> seedBarang(){
    final url = "${CommonUrl.baseUrl}/seed-barang-large";
    return get(Uri.parse(url));
  }
}