
import 'package:common/response/api_response.dart';
import 'package:fitur_autentikasi/domain/repository/i_auth_repository.dart';
import 'package:flutter/material.dart';

/// Fungsinya adalah untuk menyimpan current session token
class RouteGuardProvider extends ChangeNotifier {
  final IAuthRepository _repository;
  RouteGuardProvider({
    required IAuthRepository repository
  }) : _repository = repository;

  void setCurrentSessionToken(String newValue){
    _checkLocalTokenIsValidResponse = Future.value(
      ApiResponseSuccess(data: newValue)
    );
  }

  Future<ApiResponse>? _checkLocalTokenIsValidResponse;
  Future<ApiResponse> get checkLocalTokenIsValidResponse =>
    _checkLocalTokenIsValidResponse ??= _checkLocalTokenIsValid();
  Future<ApiResponse> _checkLocalTokenIsValid() async {
    final response = await _repository.getNewToken();
    if (response is ApiResponseSuccess<String> || response is ApiResponseFailed){
      return response;
    }
    else if (response is ApiResponseSuccess){
      throw Exception(
        "Kesalahan parsing di route guard provider, "
        "seharusnya string, tapi malah : ${response.data.runtimeType}"
      );
    }
    else {
      throw Exception(
        'Enggak mungkin, tipe Api Response yang didapat tidak diketahui'
      );
    }
  }

  void refresh(){
    _checkLocalTokenIsValidResponse = null;
    notifyListeners();
  }
}