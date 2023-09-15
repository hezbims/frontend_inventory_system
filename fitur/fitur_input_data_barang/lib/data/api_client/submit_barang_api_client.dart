
import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_input_data_barang/domain/model/submit_barang_dto.dart';

class SubmitBarangApiClient {
  final ITokenManager _tokenManager;
  SubmitBarangApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> submit(SubmitBarangDto barang) async {
    final url = "${CommonUrl.baseUrl}/barang/add";

    return post(
      Uri.parse(url),
      body: barang.json,
      headers: await _tokenManager.getTokenizedHeader(),
    );
  }

  Future<Response> edit(SubmitBarangDto submit) async {
    final url = "${CommonUrl.baseUrl}/barang/edit/${submit.json['id']}";

    return put(
      Uri.parse(url),
      body: submit.json,
      headers: await _tokenManager.getTokenizedHeader(),
    );
  }
}