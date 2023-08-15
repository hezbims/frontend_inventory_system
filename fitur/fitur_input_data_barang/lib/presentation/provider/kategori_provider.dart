import 'package:common/response/api_response.dart';
import 'package:fitur_input_data_barang/domain/repository/i_kategori_repository.dart';
import 'package:fitur_input_data_barang/domain/use_case/filter_kategori_by_keyword_use_case.dart';
import 'package:flutter/material.dart';

class KategoriProvider extends ChangeNotifier {
  final IKategoriRepository _repository;
  final kategoriFilter = FilterKategoriByKeywordUseCase();

  KategoriProvider({
    required IKategoriRepository repository
  }) : _repository = repository {
    searchController.addListener(notifyListeners);
  }

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  var _needRequestFocus = true;
  void requestFocus(){
    if (_needRequestFocus){
      _needRequestFocus = false;
      searchFocusNode.requestFocus();
    }
  }

  Future<ApiResponse>? _getKategoriResponse;
  Future<ApiResponse> get _getNotNullKategoriResponse =>
      _getKategoriResponse ??= _repository.getAllKategori();
  Future<ApiResponse> getFilteredKategori() =>
    kategoriFilter.filter(
      initialResponse: _getNotNullKategoriResponse,
      keyword: searchController.text
    );
  void onRefreshKategori(){
    _getKategoriResponse = _repository.getAllKategori();
    notifyListeners();
  }

  @override
  void dispose(){
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
