import 'dart:convert';

import 'package:common/data/api_client/notification_api_client.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationRepositoryImpl implements INotificationRepository {
  final NotificationApiClient _apiClient;
  NotificationRepositoryImpl({
    NotificationApiClient? apiClient,
  }) : _apiClient = apiClient ?? NotificationApiClient();
  @override
  Future<Stream<String>> newPengajuanNotification() async {
    try {
      debugPrint('tes notif repo impl');
      final streamResponse = await _apiClient.newPengajuanNotification();
      debugPrint('g');

      return streamResponse.stream.map((event) => utf8.decode(event));
    } catch (e) {
      debugPrint("notif repo : $e");
      rethrow;
    }
  }
}