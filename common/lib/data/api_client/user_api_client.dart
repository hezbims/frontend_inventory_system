import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:flutter/material.dart';

class UserApiClient {
  final ITokenManager tokenManager = GetIt.I.get();
  Future<Response> getUser() async {
    final url = "${CommonUrl.baseApiUrl}/get-current-user";
    debugPrint("URL : $url");
    return get(
        Uri.parse(url),
        headers: await tokenManager.getLocalStorageTokenizedHeader()
    );
  }
}