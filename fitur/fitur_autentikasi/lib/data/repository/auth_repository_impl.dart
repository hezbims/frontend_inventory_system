import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_autentikasi/data/api_client/auth_api_client.dart';
import 'package:fitur_autentikasi/data/mapper/auth_mapper.dart';
import 'package:fitur_autentikasi/domain/model/post_login_dto.dart';
import 'package:fitur_autentikasi/domain/repository/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final _apiClient = AuthApiClient();
  final _mapper = AuthMapper();

  @override
  Future<ApiResponse> login(PostLoginDto data) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.login(data),
      getModelFromBody: _mapper.getTokenFromBody,
    );
  }
}