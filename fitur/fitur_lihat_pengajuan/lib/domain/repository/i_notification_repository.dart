


abstract class INotificationRepository{
  Stream newPengajuanNotification();
  Stream<int> getNewPengajuanEvent();
  void dispose();
}