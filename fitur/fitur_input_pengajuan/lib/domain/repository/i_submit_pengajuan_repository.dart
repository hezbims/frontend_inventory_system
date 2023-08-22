import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';

abstract class ISubmitPengajuanRepository {
  Future<ApiResponse> submitData(Pengajuan data);
}