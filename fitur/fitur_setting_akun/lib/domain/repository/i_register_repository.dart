import 'package:common/response/api_response.dart';
import 'package:fitur_setting_akun/domain/model/register_dto.dart';

abstract class IRegisterRepository {
  Future<ApiResponse> register(RegisterDto data);
}