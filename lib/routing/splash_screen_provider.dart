import 'package:common/data/repository/user_repository_impl.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  final _authRepository = UserRepositoryImpl();

  Future<ApiResponse>? _getUserResponse;
  Future<ApiResponse> get getUserResponse =>
      _getUserResponse ??= _authRepository.getUser();

  void retry(){
    _getUserResponse = null;
    notifyListeners();
  }
}