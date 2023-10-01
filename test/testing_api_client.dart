import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class TestingApiClient {
  Future<Response> resetDatabase(){
    final url = "${CommonUrl.baseApiUrl}/reset-database";
    return delete(Uri.parse(url));
  }

  Future<Response> buatDuaUser(){
    final url = "${CommonUrl.baseApiUrl}/buat-dua-user";
    return post(Uri.parse(url));
  }
}