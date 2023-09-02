import 'package:common/response/api_response.dart';

abstract class IUserRepository {
  Future<ApiResponse> getUser();
}