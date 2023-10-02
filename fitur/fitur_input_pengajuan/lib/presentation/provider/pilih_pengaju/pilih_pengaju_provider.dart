
import 'package:common/response/api_response.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_filtered_group_use_case.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_sorted_group_use_case.dart';
import 'package:flutter/material.dart';

class PilihPengajuProvider extends ChangeNotifier {
  final GetSortedGroupUseCase _getSortedGroupUseCase;
  final _groupFilter = GetFilteredGroupUseCase();
  final bool isPemasok;

  PilihPengajuProvider({
    required IPengajuRepository repository,
    required this.isPemasok,
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

  Future<ApiResponse>? __getSortedGroupResponse;
  Future<ApiResponse> get _getSortedGroupResponse {
    __getSortedGroupResponse ??= _getSortedGroupUseCase.get();
    return __getSortedGroupResponse!;
  }
  Future<ApiResponse> get filteredGroupResponse {
    return _groupFilter.filter(
      apiResponse: _getSortedGroupResponse,
      keyword: searchController.text,
    );
  }

  void refresh(){
    __getSortedGroupResponse = _getSortedGroupUseCase.get();
    notifyListeners();
  }

  @override
  void dispose(){
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}