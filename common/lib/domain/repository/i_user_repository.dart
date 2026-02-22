import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/response/api_response.dart';

abstract class IUserRepository {
  Future<ApiResponse> getUser();
  User? getCurrentUser();
  Stream<ResponseWrapper<Object?, Object?>> logout();
}