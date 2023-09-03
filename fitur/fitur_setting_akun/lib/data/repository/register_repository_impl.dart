import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_setting_akun/data/api_client/register_api_client.dart';
import 'package:fitur_setting_akun/data/mapper/register_error_mapper.dart';
import 'package:fitur_setting_akun/domain/model/register_dto.dart';
import 'package:fitur_setting_akun/domain/repository/i_register_repository.dart';

class RegisterRepositoryImpl implements IRegisterRepository {
  final _apiClient = RegisterApiClient();
  final _mapper = RegisterErrorMapper();

  @override
  Future<ApiResponse> register(RegisterDto data) {
    return ApiRequestProcessor.process(
      apiRequest: _apiClient.register(data),
      getErrorMessageFromBody: _mapper.getErrorFromBody,
    );
  }

}