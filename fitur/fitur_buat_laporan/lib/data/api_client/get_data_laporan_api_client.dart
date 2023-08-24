import 'package:common/constant/url/common_url.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';

class GetDataLaporanApiClient {
  Future<Response> getDataLaporan(GeneratePdfParameterDto param){
    final url = "${CommonUrl.baseUrl}/kategori/laporan?"
      "month=${param.month}&year=${param.year}";

    return get(Uri.parse(url),);
  }
}