import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';

abstract class ICreatePengajuRepository {
  Future<ApiResponse> createPengaju(Pengaju pengaju);
}