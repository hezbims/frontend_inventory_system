import 'package:common/domain/model/user.dart';

class UserFetchState {}
class UserFetchLoading extends UserFetchState{}
class UserFetchSuccess extends UserFetchState{
  final User user;
  UserFetchSuccess({required this.user});
}
class UserFetchFailed extends UserFetchState{}