
import 'dart:convert';

import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_input_form_data_barang/domain/model/submit_barang_dto.dart';

class SubmitBarangApiClient {
  final ITokenManager _tokenManager;
  SubmitBarangApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<Response> submit(SubmitBarangDto barang) async {
    final url = "${CommonUrl.baseApiUrl}/barang/add";

    return post(
      Uri.parse(url),
      body: jsonEncode(barang.json),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }
}