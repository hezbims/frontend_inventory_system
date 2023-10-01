import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final ILoginRepository _repository = GetIt.I.get();
  LoginProvider();

  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  void turnPasswordVisibility(){
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  ApiResponse? loginResponse;
  Future<void> Function()? get login {
    if (loginResponse is ApiResponseLoading){
      return null;
    }
    return _login;
  }
  Future<void> _login() async {
    if (loginResponse is! ApiResponseLoading){
      loginResponse = ApiResponseLoading();
      notifyListeners();

      loginResponse = await _repository.login(PostLoginDto(
        password: passwordC.text, username: usernameC.text)
      );

      if (loginResponse is ApiResponseFailed){
        Fluttertoast.showToast(
          msg: (loginResponse as ApiResponseFailed).error.toString(),
          timeInSecForIosWeb: 5,
        );
      }

      notifyListeners();
    }
  }

  @override
  void dispose(){
    usernameC.dispose();
    passwordC.dispose();
    super.dispose();
  }
}