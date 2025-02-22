
import 'package:common/domain/helper/my_debouncer_helper.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_stock_barang/presentation/model/filter_state.dart';
import 'package:flutter/material.dart';

class LihatStockBarangProvider extends ChangeNotifier {
  final IBarangRepository _repository;
  final _debouncer = MyLatestQueueDebouncerHelper<ApiResponse>();
  LihatStockBarangProvider({
    required IBarangRepository repository,
  }) : _repository = repository {
    refreshListBarang();
  }

  void refreshListBarang() async {
    _debouncer.run(
      process: (){
        _listBarangResponse = ApiResponseLoading();
        notifyListeners();
        return _repository.getStockBarangPaginated(
            pageNumber: _filterState.pageNumber,
            keyword: _filterState.searchKeyword,
            idKategori: _filterState.categoryId
        );
      },
      onDone: (response){
        _listBarangResponse = response;
        notifyListeners();
      }
    );
  }

  FilterState _filterState = FilterState.init();
  FilterState get filterState => _filterState;
  ApiResponse _listBarangResponse = ApiResponseLoading();
  ApiResponse get listBarangResponse => _listBarangResponse;

  void setChoosenIdKategori(int newIdKategori) {
    if (newIdKategori != _filterState.categoryId) {
      _filterState = _filterState.copyWith(categoryId: newIdKategori);
    }
  }

  void onClickForwardPage(){
    _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber + 1);
    notifyListeners();
  }

  void onClickBackwardPage(){
    _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber - 1);
    notifyListeners();
  }

  void onClickToLatestPage(){
    // _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber + 1);
    // notifyListeners();
  }

  void onClickToFirstPage(){
    // _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber + 1);
    // notifyListeners();
  }
}