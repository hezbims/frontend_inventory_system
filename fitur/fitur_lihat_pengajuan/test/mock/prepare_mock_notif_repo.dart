import 'package:mocktail/mocktail.dart';

import 'mock_notif_repository.dart';

MockNotifRepository prepareMockNotifRepo(){
  final mockNotifRepo = MockNotifRepository();
  when(() => mockNotifRepo.getNewPengajuanEvent()).thenAnswer(
    (invocation) => const Stream.empty(),
  );
  return mockNotifRepo;
}