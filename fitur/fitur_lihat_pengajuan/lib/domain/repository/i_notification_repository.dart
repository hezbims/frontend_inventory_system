abstract class INotificationRepository{
  void observePengajuanDataVersion({
    required void Function(int pengajuanDataVersion) onEvent,
    required void Function() onDisconnected,
  });

  /// Observer Server-Sent Event for Transaction List
  Stream<int> getSseTransaction();
  void dispose();
}