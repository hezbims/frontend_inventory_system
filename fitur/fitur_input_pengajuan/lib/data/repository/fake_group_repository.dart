import 'package:common/response/api_response.dart';
import 'package:common/domain/model/group.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_group_repository.dart';

class FakeGroupRepository implements IGroupRepository {
  final _groups = [
    Group(namaGroup: "D20-E3", groupId: 1),
    Group(namaGroup: "T3F", groupId: 2),
    Group(namaGroup: "24JPL", groupId: 3),
    Group(namaGroup: "B40003E420", groupId: 4),
    Group(namaGroup: "E65", groupId: 5),
    Group(namaGroup: "700G24", groupId: 6),
    Group(namaGroup: "T36JFG", groupId: 7),
    Group(namaGroup: "B1", groupId: 8),
    Group(namaGroup: "EVZ74G", groupId: 9),
  ];
  @override
  Future<ApiResponse> getGroups() {
    return Future.delayed(
      const Duration(milliseconds: 1500) ,
      () => ApiResponseSuccess(data : _groups),
    );
  }
}