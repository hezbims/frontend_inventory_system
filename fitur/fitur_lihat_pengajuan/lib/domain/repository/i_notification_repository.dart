


abstract class INotificationRepository{
  Stream getWebSocketStream();
  Stream<int> getNewPengajuanEvent();
  void dispose();
}