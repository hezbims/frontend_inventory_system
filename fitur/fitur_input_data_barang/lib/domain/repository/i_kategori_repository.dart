import 'package:common/response/api_response.dart';

abstract class IKategoriRepository {
  Future<ApiResponse> getAllKategori();
}