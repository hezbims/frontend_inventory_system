import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_pengajuan/data/repository/lihat_pengajuan_repository_impl.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Pastikan pengajuan yang didapat dari API sudah terformat dengan benar', () async {
    final repository = LihatPengajuanRepositoryImpl();

    // TODO : seed database


    final response = await repository.getPengajuanPreview(
        pageNumber: 1, keyword: "", idPengaju: null
    );
    assert(response is ApiResponseSuccess<List<PengajuanPreview>>);
  });
}
