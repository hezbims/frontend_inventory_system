import 'package:common/domain/model/user.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/user_fetch_state.dart';
import 'package:flutter/material.dart';

class MyRouteStateProvider extends ChangeNotifier {
  UserFetchResponse _currentUser = UserFetchLoading();
  UserFetchResponse get currentUser => _currentUser;

  MyRouteState _currentRouteState = RouteLihatStockBarangState();
  MyRouteState get currentState => _currentRouteState;

  /// This method will set [_currentUser] as unatuthenticated, so the user will be moved to login page.
  /// Beware that [_currentUser] is unrelated to the currentUser in repository.
  ///
  /// Whenever login succeed, user will be moved based on [afterLoginSucceedRouteState].
  ///
  /// If you don't provide [afterLoginRouteState], you will be moved to default home in
  /// Product Stock List Screen
  void setStateUnauthenticated({
    MyRouteState? afterLoginSucceedRouteState
  }){
    _currentUser = UserFetchFailed();
    _currentRouteState = afterLoginSucceedRouteState ?? RouteLihatStockBarangState();

    notifyListeners();
  }
  void setAuthenticatedUser(User user) async {
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


