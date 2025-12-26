import 'package:common/domain/model/user.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/material.dart';

class MyRouteStateProvider extends ChangeNotifier {
  UserFetchResponse _currentUser = UserFetchLoading();
  UserFetchResponse get currentUser => _currentUser;

  MyRouteState _currentRouteState = RouteLihatStockBarangState();
  MyRouteState get currentState => _currentRouteState;

  void setStateUnauthenticated({
    required MyRouteState? nextRouteState
  }){
    if (GetIt.I.isRegistered<User>()) {
      GetIt.I.unregister<User>();
    }
    _currentUser = UserFetchFailed();
    if (nextRouteState != null){
      _currentRouteState = nextRouteState;
    }
    notifyListeners();
  }
  void onLogin(User user) async {
    _currentUser = UserFetchSuccess(user: user);
    notifyListeners();
  }

  void setRouteState(MyRouteState newRouteState , {bool notifyListener = true}){
    _currentRouteState = newRouteState;
    if (notifyListener) {
      notifyListeners();
    }
  }
}


