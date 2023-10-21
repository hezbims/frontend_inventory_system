

abstract class INotificationRepository{
  Stream newPengajuanNotification();
  Future<Stream<String>> testSse();
}