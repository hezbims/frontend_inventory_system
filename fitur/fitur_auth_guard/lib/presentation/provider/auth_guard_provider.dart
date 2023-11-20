import 'package:common/domain/model/user.dart';
import 'package:common/domain/repository/i_user_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/material.dart';

/// Fungsinya adalah untuk menyimpan current session token
class AuthGuardProvider extends ChangeNotifier {
  final IUserRepository _repository;
  AuthGuardProvider({
    required IUserRepository repository
  }) : _repository = repository;

  // TODO : buat testing bolak balik. Pastiin kalo udah pernah login, gak perlu login lagi

  Future<ApiResponse>? _getUserResponse;

  /// Token yang ada di shared preferences bisa jadi sudah kadaluarsa,
  /// oleh karena itu, variabel ini dibuat. Veriabel ini dibuat karena token yang di simpan di
  /// variabel ini sudah pasti tidak kadaluarsa ketika aplikasi berjalan. Mengapa begitu?
  /// karena token yang didapat dari variabel ini akan direfresh setiap
  /// aplikasi mulai berjalan. masa dari token yang baru saja didapatkan adalah
  /// 1 bulan.
  Future<ApiResponse> get getUserResponse async {
    try {
      debugPrint('masuk sini, coba dapetin user');
      GetIt.I.get<User>();
      debugPrint('tes');
      return Future.value(
        ApiResponseSuccess(
          data: GetIt.I.get<User>()
        )
      );
    } catch (e) {
      return _getUserResponse ??= _getUser();
    }
  }
  Future<ApiResponse> _getUser() async {
    final response = await _repository.getUser();
    if (response is ApiResponseSuccess<User> || response is ApiResponseFailed){
      debugPrint('response sukses');
      if (response is ApiResponseSuccess<User>) {
        _getItRegisterUser(response.data!);
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

  void onLogoutSuccess(){
    _getUserResponse = Future.value(ApiResponseFailed(statusCode: 401));
  }

  void _getItRegisterUser(User user){
    if (GetIt.I.isRegistered<User>()){
      GetIt.I.unregister<User>();
    }
    debugPrint("NGEREGISTER user");
    GetIt.I.registerSingleton(user);
  }

  void refresh(){
    _getUserResponse = null;
    notifyListeners();
  }
}