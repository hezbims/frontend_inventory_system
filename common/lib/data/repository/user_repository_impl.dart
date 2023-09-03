import 'package:common/data/api_client/user_api_client.dart';
import 'package:common/data/mapper/user_mapper.dart';
import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/response/api_response.dart';

class UserRepositoryImpl implements IUserRepository {
  final _apiClient = UserApiClient();
  final _mapper = UserMapper();
  @override
  Future<ApiResponse> getUser() async {
    final response = await ApiRequestProcessor.process(
      apiRequest: _apiClient.getUser(),
      getModelFromBody: _mapper.getUserFromBody,
    );

    if (response is ApiResponseSuccess<User>){
      await TokenManager.setToken(response.data!.token);
    }
    return response;
  }

}