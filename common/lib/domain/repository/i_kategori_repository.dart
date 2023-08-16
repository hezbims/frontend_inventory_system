import 'package:common/response/api_response.dart';

abstract class IKategoriRepository {
  Future<ApiResponse> getAllKategori();
  Future<ApiResponse> addNewKategori(String newKategori);
}