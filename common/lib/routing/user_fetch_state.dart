import 'package:common/domain/model/user.dart';

class UserFetchResponse {}
class UserFetchLoading extends UserFetchResponse{}
class UserFetchSuccess extends UserFetchResponse{
  final User user;
  UserFetchSuccess({required this.user});
}
class UserFetchFailed extends UserFetchResponse{}