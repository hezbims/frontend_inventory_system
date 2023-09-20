import 'package:common/data/repository/notification_repository_impl.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final INotificationRepository _repository;
  NotificationProvider({
    INotificationRepository? repository,
  }) : _repository = repository ?? NotificationRepositoryImpl();

 void test() async {
   _repository.newPengajuanNotification().listen((event) {
     debugPrint("ada event : $event");
   });
 }
}