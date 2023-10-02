
import 'package:common/response/api_response.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_filtered_group_use_case.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_sorted_group_use_case.dart';
import 'package:flutter/material.dart';

class PilihPengajuProvider extends ChangeNotifier {
  final GetSortedGroupUseCase _getSortedGroupUseCase;
  final _groupFilter = GetFilteredGroupUseCase();

  PilihPengajuProvider({
    required IPengajuRepository repository,
    required bool isPemasok,
  }) : _getSortedGroupUseCase = GetSortedGroupUseCase(
        repository: repository,
        isPemasok: isPemasok,
      ),
      searchController = TextEditingController() {
    searchController.addListener(notifyListeners);
  }

  final TextEditingController searchController;
  final searchFocusNode = FocusNode();
  var _needRequestFocus = true;
  void requestFocus(){
    if (_needRequestFocus){
      _needRequestFocus = false;
      searchFocusNode.requestFocus();
    }
  }

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

  void refresh(){
    _getSortedGroupResponse = _getSortedGroupUseCase.get();
    notifyListeners();
  }

  @override
  void dispose(){
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}