

import 'package:common/response/api_response.dart';

abstract class INotificationRepository{
  Stream newPengajuanNotification();
  Stream<int> getNewPengajuanEvent();
  Future<ApiResponse> acknowledgeNewPengajuan();
  void dispose();
}