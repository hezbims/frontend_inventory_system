
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_group_repository.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_filtered_group_use_case.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_sorted_group_use_case.dart';
import 'package:flutter/material.dart';

class PilihGroupProvider extends ChangeNotifier {
  final GetSortedGroupUseCase _getSortedGroupUseCase;
  final _groupFilter = GetFilteredGroupUseCase();

  PilihGroupProvider({
    required IGroupRepository repository
  }) : _getSortedGroupUseCase = GetSortedGroupUseCase(
        repository: repository
      ),
      searchController = TextEditingController() {
    searchController.addListener(notifyListeners);
  }

  final TextEditingController searchController;

  Future<ApiResponse>? _getSortedGroupResponse;
  Future<ApiResponse> get getSortedGroupResponse {
    _getSortedGroupResponse ??= _getSortedGroupUseCase.get();
    return _getSortedGroupResponse!;
  }
  Future<ApiResponse> get filteredGroupResponse {
    return _groupFilter.filter(
      apiResponse: getSortedGroupResponse,
      keyword: searchController.text,
    );
  }

  void onRefreshGroup(){
    _getSortedGroupResponse = _getSortedGroupUseCase.get();
    notifyListeners();
  }

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }
}