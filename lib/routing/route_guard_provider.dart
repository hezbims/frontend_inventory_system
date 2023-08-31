
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
    _getCurrentSessionTokenResponse = Future.value(
      ApiResponseSuccess(data: newValue)
    );
  }

  // TODO : buat testing bolak balik. Pastiin kalo udah pernah login, gak perlu login lagi

  Future<ApiResponse>? _getCurrentSessionTokenResponse;

  /// Token yang ada di shared preferences bisa jadi sudah kadaluarsa,
  /// oleh karena itu, variabel ini dibuat. Veriabel ini dibuat karena token yang di simpan di
  /// variabel ini sudah pasti tidak kadaluarsa ketika aplikasi berjalan. Mengapa begitu?
  /// karena token yang didapat dari variabel ini akan direfresh setiap
  /// aplikasi mulai berjalan. masa dari token yang baru saja didapatkan adalah
  /// 1 bulan.
  Future<ApiResponse> get getCurrentSessionTokenResponse =>
    _getCurrentSessionTokenResponse ??= _getCurrentSessionToken();
  Future<ApiResponse> _getCurrentSessionToken() async {
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
    _getCurrentSessionTokenResponse = null;
    notifyListeners();
  }
}