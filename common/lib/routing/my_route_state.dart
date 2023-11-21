import 'package:common/routing/user_fetch_state.dart';

class MyRouteState {
  UserFetchState _getUserResponse;
  UserFetchState get getUserResponse => _getUserResponse;
  void setUserResponse(UserFetchState response){
    _getUserResponse = response;
  }
  MyRouteState({
    UserFetchState? getUserResponse
  }) : _getUserResponse = getUserResponse ?? UserFetchLoading();
}

// DEPTH 1
class RouteLoginState extends MyRouteState{}

class RouteLihatStockBarangState extends MyRouteState {
  RouteLihatStockBarangState({super.getUserResponse});
}

class RoutePilihTahunBulanLaporanState extends MyRouteState {
  RoutePilihTahunBulanLaporanState({super.getUserResponse});
}

class RouteLihatPengajuanState extends MyRouteState {
  RouteLihatPengajuanState({super.getUserResponse});
}

class RouteSettingAkunState extends MyRouteState {
  RouteSettingAkunState({super.getUserResponse});
}