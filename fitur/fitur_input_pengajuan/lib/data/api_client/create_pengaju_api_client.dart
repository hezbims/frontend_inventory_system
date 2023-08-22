import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class CreatePengajuApiClient {
  Future<Response> createPengaju(String body) {
    const url = "${CommonUrl.baseUrl}/pengaju/add";
    return post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }
}