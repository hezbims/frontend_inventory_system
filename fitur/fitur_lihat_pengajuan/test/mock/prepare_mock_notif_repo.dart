import 'package:mocktail/mocktail.dart';

import 'mock_notif_repository.dart';

MockNotifRepository prepareMockNotifRepo(){
  final mockNotifRepo = MockNotifRepository();
  when(() => mockNotifRepo.observePengajuanDataVersion(
    onEvent: any(),
    onDisconnected: any()
  )).thenAnswer(
    (invocation) => {},
  );
  return mockNotifRepo;
}