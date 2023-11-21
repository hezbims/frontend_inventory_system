
import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_setting_akun/domain/repository/i_setting_akun_repository.dart';
import 'package:flutter/material.dart';

class SettingAkunProvider extends ChangeNotifier {
  final ISettingAkunRepository _repository;
  SettingAkunProvider({
    required ISettingAkunRepository repository,
  }) : _repository = repository;

  ApiResponse? logoutResponse;
  void tryLogout() async {
    if (!isLoading){
      logoutResponse = ApiResponseLoading();
      notifyListeners();

      logoutResponse = await _repository.logout();
      if (logoutResponse is ApiResponseFailed){
        Fluttertoast.showToast(
          msg: (logoutResponse as ApiResponseFailed).error.toString(),
          timeInSecForIosWeb: 5,
        );
      }
      notifyListeners();
    }
  }

  bool get logoutSuccess {
    return logoutResponse is ApiResponseSuccess;
  }
  bool get isLoading {
    return logoutResponse is ApiResponseLoading;
  }
}