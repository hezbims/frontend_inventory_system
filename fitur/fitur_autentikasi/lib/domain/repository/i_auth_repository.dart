import 'package:common/response/api_response.dart';
import 'package:fitur_autentikasi/domain/model/post_login_dto.dart';

abstract class IAuthRepository {
  Future<ApiResponse> login(PostLoginDto data);
  Future<ApiResponse> getNewToken();
}