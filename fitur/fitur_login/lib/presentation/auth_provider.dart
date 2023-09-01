import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_login/domain/model/post_login_dto.dart';
import 'package:fitur_login/domain/repository/i_auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final IAuthRepository _repository;
  AuthProvider({
    required IAuthRepository repository,
  }) : _repository = repository;

  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  ApiResponse? loginResponse;
  void Function()? get login {
    if (loginResponse is ApiResponseLoading){
      return null;
    }
    return _login;
  }
  void _login() async {
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