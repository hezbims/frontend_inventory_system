import 'package:common/data/mapper/user/get_user_mapper.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_auth_guard/data/api_client/login_api_client.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';

class LoginRepositoryImpl implements ILoginRepository {
  final LoginApiClient _apiClient;
  final ITokenManager _tokenManager;
  LoginRepositoryImpl({
    required LoginApiClient apiClient,
    required ITokenManager tokenManager
  }) : _apiClient = apiClient , _tokenManager = tokenManager;

  final _mapper = GetUserMapper();

  @override
  Future<ApiResponse> login(PostLoginDto data) async {
    final response = await ApiRequestProcessor.process(
      apiRequest: _apiClient.login(data),
      getModelFromBody: _mapper.getUserFromBody,
    );

    if (response is ApiResponseSuccess<User>){
      await _tokenManager.setToken(response.data!.token);
    }
    return response;
  }
}