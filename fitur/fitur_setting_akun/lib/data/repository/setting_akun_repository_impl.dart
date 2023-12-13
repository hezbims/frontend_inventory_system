import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_setting_akun/data/api_client/setting_akun_api_client.dart';
import 'package:fitur_setting_akun/domain/repository/i_setting_akun_repository.dart';

class SettingAkunRepositoryImpl implements ISettingAkunRepository {
  final _apiClient = SettingAkunApiClient();
  final ITokenManager _tokenManager = GetIt.I.get();
  @override
  Future<ApiResponse> logout() async {
    // gunain yang dicomment ini, kalau logoutnya pake stateful authentication
    // final response = await ApiRequestProcessor.process(apiRequest: _apiClient.logout());
    final response = ApiResponseSuccess();

    //if (response is ApiResponseSuccess){
      await _tokenManager.clearToken();
    //}

    return response;
  }

}