import 'package:common/response/api_response.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';

abstract class ILoginRepository {
  Future<ApiResponse> login(PostLoginDto data);
}