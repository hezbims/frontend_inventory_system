import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';

class SubmitPengajuanApiClient {
  Future<Response> submitData(String body){
    const url = "${CommonUrl.baseUrl}/pengajuan/add";

    return post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
    );
  }
}