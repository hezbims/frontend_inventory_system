import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  final IUserRepository _authRepository = GetIt.I.get();

  Future<ApiResponse>? _getUserResponse;
  Future<ApiResponse> get getUserResponse =>
      _getUserResponse ??= _authRepository.getUser();

  void retry(){
    _getUserResponse = null;
    notifyListeners();
  }
}