import 'package:common/response/api_response.dart';

abstract class IGroupRepository {
  Future<ApiResponse> getGroups();
}