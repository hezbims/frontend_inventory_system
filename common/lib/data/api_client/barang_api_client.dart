import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/model/rak.dart';
import 'package:dependencies/http.dart';

class BarangApiClient {
  Future<Response> getBarang(int pageNumber , String keyword){
    final getBarangUrl = "${CommonUrl.baseUrl}/barang/all?page=$pageNumber&keyword=$keyword";
    return get(Uri.parse(getBarangUrl));
  }

  Future<Response> cekRak(Rak rak){
    final cekRakUrl = "${CommonUrl.baseUrl}/rak/check";
    return post(
      Uri.parse(cekRakUrl),
      body: rak.toJson(),
    );
  }
}