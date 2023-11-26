
import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/file_picker.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';

class BarangApiClient {
  final ITokenManager _tokenManager;
  BarangApiClient({
    ITokenManager? tokenManager,
  }) : _tokenManager = tokenManager ?? GetIt.I.get();

  Future<Response> getBarang({
    required int pageNumber,
    required String keyword,
    required int idKategori,
  }) async {
    final getBarangUrl = "${CommonUrl.baseApiUrl}/barang/all?"
        "page=$pageNumber&"
        "keyword=$keyword&"
        "id_kategori=$idKategori";
    return get(
      Uri.parse(getBarangUrl),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }

  Future<Response> getDetailBarang({required int id}) async {
    final url = "${CommonUrl.baseApiUrl}/barang/detail/$id";
    return get(
      Uri.parse(url),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }

  Future<Response> submitExcelDataBarang({
    required PlatformFile file,
    required bool isUpsert,
  }) async {
    final url = "${CommonUrl.baseApiUrl}/barang/submit-excel";
    final request = MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(_tokenManager.getCurrentSessionTokenizedHeader());
    request.headers.addAll({'content-type' : 'multipart/form-data'});
    request.files.add(
      MultipartFile.fromBytes('excel', file.bytes!, filename: 'excel.xlsx')
    );
    request.fields.addAll({'is_upsert' : isUpsert.toString()});

    return Response.fromStream(await request.send());
  }
}