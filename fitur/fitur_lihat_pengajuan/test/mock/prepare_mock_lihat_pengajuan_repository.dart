import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_lihat_pengajuan_repository.dart';

MockLihatPengajuanRepository prepareMockLihatPengajuanRepository() {
  final mock = MockLihatPengajuanRepository();

  final listPengajuan = [
    PengajuanPreview(
      id: 1,
      namaPengaju: 'grup-1',
      isPemasok: false,
      kodeTransaksi: 'trx1',
      username: 'asep',
      status: StatusPengajuan.menunggu,
    ),
    PengajuanPreview(
      id: 2,
      namaPengaju: 'grup-2',
      isPemasok: false,
      kodeTransaksi: 'trx2',
      username: 'budi',
      status: StatusPengajuan.menunggu,
    ),
    PengajuanPreview(
      id: 3,
      namaPengaju: 'pemasok-1',
      isPemasok: true,
      kodeTransaksi: 'trx3',
      username: 'admin',
      status: StatusPengajuan.diterima,
    ),

  ];

  when(() => mock.getPengajuanPreview(
      pageNumber: any(named: 'pageNumber'),
      keyword: any(named: 'keyword'),
      idPengaju: null
    )
  ).thenAnswer(
    (invocation) async => ApiResponseSuccess(data: listPengajuan),
  );
  when(() => mock.getPengajuanPreview(
      pageNumber: any(named: 'pageNumber'),
      keyword: any(named: 'keyword'),
      idPengaju: 2,
    ),
  ).thenAnswer(
    (invocation) async => ApiResponseSuccess(data: [listPengajuan[1]]),
  );
  return mock;
}