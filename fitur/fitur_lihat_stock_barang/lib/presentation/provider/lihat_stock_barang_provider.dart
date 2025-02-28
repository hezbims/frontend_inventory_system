
import 'package:common/domain/helper/my_debouncer_helper.dart';
import 'package:common/domain/model/page_result.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:fitur_lihat_stock_barang/domain/model/filter_state.dart';
import 'package:fitur_lihat_stock_barang/domain/model/preview_barang.dart';
import 'package:fitur_lihat_stock_barang/domain/use_case/get_preview_stock_barang.dart';
import 'package:flutter/material.dart';

class LihatStockBarangProvider extends ChangeNotifier {
  final GetPreviewStockBarang _getPreviewStockBarang;
  final _debouncer = MyLatestQueueDebouncerHelper<ResponseWrapper<PageResult<PreviewBarang>, Object>>();
  LihatStockBarangProvider({
    required GetPreviewStockBarang getPreviewStockBarang,
  }) : _getPreviewStockBarang = getPreviewStockBarang {
    refreshListBarang();
  }

  void refreshListBarang() async {
    _debouncer.run(
      process: (){
        _listBarangResponse = ResponseLoading();
        notifyListeners();
        return _getPreviewStockBarang.execute(_filterState);
      },
      onDone: (response){
        _listBarangResponse = response;
        notifyListeners();
      }
    );
  }

  FilterState _filterState = FilterState.init();
  FilterState get filterState => _filterState;
  ResponseWrapper<PageResult<PreviewBarang>, Object> _listBarangResponse = ResponseLoading();
  ResponseWrapper<PageResult<PreviewBarang>, Object> get listBarangResponse => _listBarangResponse;

  bool get hasNextPage {
    final currentResponse = _listBarangResponse;
    return switch(currentResponse){
      ResponseSucceed() => currentResponse.data.links.nextPage != null,
      ResponseFailed() || ResponseLoading() => false,
    };
  }

  bool get hasPrevPage {
    final currentResponse = _listBarangResponse;
    return switch(currentResponse){
      ResponseSucceed() => currentResponse.data.links.prevPage != null,
      ResponseFailed() || ResponseLoading() => false,
    };
  }

  void changeSearchQuery(String newSearchQuery){
    _filterState = _filterState.copyWith(
      searchKeyword: newSearchQuery,
      pageNumber: 1,
    );
    refreshListBarang();
  }

  void setChoosenIdKategori(int newIdKategori) {
    if (newIdKategori != _filterState.categoryId) {
      _filterState = _filterState.copyWith(categoryId: newIdKategori);
    }
  }

  void onClickForwardPage(){
    _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber + 1);
    refreshListBarang();
  }

  void onClickBackwardPage(){
    _filterState = _filterState.copyWith(pageNumber: _filterState.pageNumber - 1);
    refreshListBarang();
  }

  void onClickToLatestPage(){
    final currentResponse = _listBarangResponse;
    if (currentResponse is ResponseSucceed<PageResult<PreviewBarang>, Object>) {
      _filterState = _filterState.copyWith(
          pageNumber: currentResponse.data.links.lastPage);
      refreshListBarang();
    }
  }

  void onClickToFirstPage(){
    final currentResponse = _listBarangResponse;
    if (currentResponse is ResponseSucceed<PageResult<PreviewBarang>, Object>) {
      _filterState = _filterState.copyWith(pageNumber: 1);
      refreshListBarang();
    }
  }
}