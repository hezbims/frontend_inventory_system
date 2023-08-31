
import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';

class SubmitBarangApiClient {
  Future<Response> submit(SubmitBarangDto barang){
    final url = "${CommonUrl.baseUrl}/barang/add";

    return post(
      Uri.parse(url),
      body: barang.json,
    );
  }

  Future<Response> edit(SubmitBarangDto submit){
    final url = "${CommonUrl.baseUrl}/barang/edit/${submit.json['id']}";

    return put(
      Uri.parse(url),
      body: submit.json
    );
  }
}