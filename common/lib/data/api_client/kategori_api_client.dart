import 'dart:convert';

import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';

class KategoriApiClient {
  final _tokenManager = GetIt.I.get<ITokenManager>();

  Future<Response> getAllKategori() async {
    final getUrl = "${CommonUrl.baseApiUrl}/kategori/all";
    return get(
      Uri.parse(getUrl),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }

  Future<Response> addNewKategori(String namaKategori) async {
    final postUrl = "${CommonUrl.baseApiUrl}/kategori/add";

    return post(
      Uri.parse(postUrl),
      body: jsonEncode({'nama' : namaKategori}),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }
}