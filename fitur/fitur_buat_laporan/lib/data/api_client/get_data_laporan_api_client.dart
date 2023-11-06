import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';

class GetDataLaporanApiClient {
  final _tokenManager = GetIt.I.get<ITokenManager>();
  Future<Response> getDataLaporan(GeneratePdfParameterDto param) async {
    final url = "${CommonUrl.baseApiUrl}/kategori/laporan?"
      "month=${param.month}&year=${param.year}";

    return get(
      Uri.parse(url),
      headers: _tokenManager.getCurrentSessionTokenizedHeader(),
    );
  }
}