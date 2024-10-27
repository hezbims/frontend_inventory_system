abstract class INotificationRepository{
  void observePengajuanDataVersion({
    required void Function(int pengajuanDataVersion) onEvent,
    required void Function() onDisconnected,
  });
  void dispose();
}