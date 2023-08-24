import 'package:common/response/api_response.dart';
import 'package:fitur_buat_laporan/domain/model/generate_pdf_parameter_dto.dart';

abstract class IGetDataLaporanRepository {
  Future<ApiResponse> getDataLaporan(GeneratePdfParameterDto param);
}