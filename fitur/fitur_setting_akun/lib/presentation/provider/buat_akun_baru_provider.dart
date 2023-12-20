import 'package:common/response/api_response.dart';
import 'package:fitur_setting_akun/domain/model/register_dto.dart';
import 'package:fitur_setting_akun/domain/repository/i_register_repository.dart';
import 'package:flutter/material.dart';

class BuatAkunBaruProvider extends ChangeNotifier {
  final IRegisterRepository _repository;
  BuatAkunBaruProvider({
    required IRegisterRepository repository
  }) : _repository = repository;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  void onChangeCheckbox(bool? nextValue){
    if (nextValue != null) {
      _isAdmin = nextValue;
      notifyListeners();
    }
  }

  Map<String , String?> errorMap = {};

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  void turnPasswordVisibility(){
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool _isConfirmPasswordVisible = false;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  void turnConfirmPasswordVisibility(){
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  ApiResponse? _registerResponse;
  ApiResponse? get registerResponse => _registerResponse;
  void Function()? get register{
    if (_registerResponse is ApiResponseLoading) {
      return null;
    }
    return _register;
  }
  void _register() async {
    _registerResponse = ApiResponseLoading();
    notifyListeners();

    if (passwordController.text != confirmPasswordController.text){
      _registerResponse = ApiResponseFailed();
      errorMap['password'] = 'Password tidak sama';
      notifyListeners();
      return;
    }

    _registerResponse = await _repository.register(
      RegisterDto(
        username: usernameController.text,
        password: passwordController.text,
        isAdmin: _isAdmin,
      ),
    );
    debugPrint("register response type : ${_registerResponse.runtimeType}");

    if (_registerResponse is ApiResponseFailed){
      errorMap = (_registerResponse as ApiResponseFailed).error;
    }
    notifyListeners();
  }



  @override
  void dispose(){
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
}