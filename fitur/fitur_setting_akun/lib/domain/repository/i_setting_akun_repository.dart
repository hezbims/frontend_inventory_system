import 'package:common/response/api_response.dart';

abstract class ISettingAkunRepository {
  Future<ApiResponse> logout();
}