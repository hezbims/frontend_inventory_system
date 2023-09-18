import 'dart:io';

import 'package:common/constant/url/common_url.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/http.dart';
import 'package:flutter/material.dart';

class NotificationApiClient {
  final ITokenManager _tokenManager;
  NotificationApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? TokenManagerImpl();

  Future<StreamedResponse> newPengajuanNotification() async {
    final url = "${CommonUrl.baseUrl}/pengajuan/new-pengajuan-notification";

    final tokenizedHeader = await _tokenManager.getTokenizedHeader();

    final request = Request('GET', Uri.parse(url));

    request.headers[HttpHeaders.authorizationHeader] = tokenizedHeader[HttpHeaders.authorizationHeader]!;
    request.headers[HttpHeaders.cacheControlHeader] = 'no-cache';
    request.headers[HttpHeaders.acceptHeader] = 'text/event-stream; charset=UTF-8';

    debugPrint("sebelum request send ${request.headers.toString()}");

    return await request.send();


  }
}