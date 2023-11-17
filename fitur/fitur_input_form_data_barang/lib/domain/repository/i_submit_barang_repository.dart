import 'package:common/response/api_response.dart';
import 'package:fitur_input_form_data_barang/domain/model/submit_barang_dto.dart';

abstract class ISubmitBarangRepository {
  Future<ApiResponse> submitDataBarang(SubmitBarangDto barang);
}