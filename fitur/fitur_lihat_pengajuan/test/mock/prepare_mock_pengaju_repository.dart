import 'package:common/domain/model/pengaju.dart';
import 'package:common/response/api_response.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_pengaju_repository.dart';

MockPengajuRepository prepareMockPengajuRepository() {
  final mockRepo = MockPengajuRepository();
  when(() => mockRepo.getPengaju(false)).thenAnswer(
        (invocation) async => ApiResponseSuccess(data : [
      Pengaju(nama: 'grup-1', id: 1, isPemasok: false),
      Pengaju(nama: 'grup-2', id: 2, isPemasok: false),
      Pengaju(nama: 'grup-3', id: 3, isPemasok: false),
    ]),
  );
  when(() => mockRepo.getPengaju(true)).thenAnswer(
        (invocation) async => ApiResponseSuccess(data : [
      Pengaju(nama: 'pemasok-1', id: 4, isPemasok: true),
      Pengaju(nama: 'pemasok-2', id: 5, isPemasok: true),
      Pengaju(nama: 'pemasok-3', id: 6, isPemasok: true),
    ]),
  );
  return mockRepo;
}