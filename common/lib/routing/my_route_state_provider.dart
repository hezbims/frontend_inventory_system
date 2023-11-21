import 'package:common/domain/model/user.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:dependencies/get_it.dart';
import 'package:flutter/material.dart';

class MyRouteStateProvider extends ChangeNotifier {
  MyRouteState _currentState = RouteLihatStockBarangState();
  MyRouteState get currentState => _currentState;

  void setStateUnauthenticated(){
    if (GetIt.I.isRegistered<User>()) {
      GetIt.I.unregister<User>();
    }
    _currentState.setUserResponse(UserFetchFailed());
    notifyListeners();
  }
  void setStateAuthenticated(User user){
    GetIt.I.registerSingleton(user);
    _currentState.setUserResponse(
      UserFetchSuccess(user: user)
    );
    notifyListeners();
  }

  void setRouteState(MyRouteState newRouteState){
    _currentState = newRouteState;
    notifyListeners();
  }
}


