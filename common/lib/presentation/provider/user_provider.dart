import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

/// Fungsinya adalah untuk menyimpan current session token
class UserProvider extends ChangeNotifier {
  final IUserRepository _repository;
  UserProvider({
    required IUserRepository repository
  }) : _repository = repository;

  // TODO : buat testing bolak balik. Pastiin kalo udah pernah login, gak perlu login lagi

  // Untuk digunain ngecek apakah admin atau bukan
  User? _currentUser;
  User get currentUser => _currentUser!;

  Future<ApiResponse>? _getUserResponse;

  /// Token yang ada di shared preferences bisa jadi sudah kadaluarsa,
  /// oleh karena itu, variabel ini dibuat. Veriabel ini dibuat karena token yang di simpan di
  /// variabel ini sudah pasti tidak kadaluarsa ketika aplikasi berjalan. Mengapa begitu?
  /// karena token yang didapat dari variabel ini akan direfresh setiap
  /// aplikasi mulai berjalan. masa dari token yang baru saja didapatkan adalah
  /// 1 bulan.
  Future<ApiResponse> get getUserResponse =>
    _getUserResponse ??= _getUser();
  Future<ApiResponse> _getUser() async {
    final response = await _repository.getUser();
    if (response is ApiResponseSuccess<User> || response is ApiResponseFailed){
      if (response is ApiResponseSuccess<User>){
        _currentUser = response.data;
      }
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
  void onLoginSuccess(User user){
    _getUserResponse = Future.value(
      ApiResponseSuccess(data: user)
    );
    _currentUser = user;
  }
  void onLogoutSuccess(){
    _getUserResponse = Future.value(ApiResponseFailed(statusCode: 401));
  }

  void refresh(){
    _getUserResponse = null;
    notifyListeners();
  }
}