import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:common/utils/disposable_change_notifier.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_barang_preview_use_case.dart';
import 'package:flutter/material.dart';

class PilihBarangProvider extends DisposableChangeNotifier {
  final GetBarangPreviewUseCase _getBarangPreviewUseCase;
  final bool isPemasukan;
  Function(BarangPreview)? showBottomSheet;

  PilihBarangProvider({
    required IBarangRepository barangRepository,
    required this.isPemasukan,
    required this.choosenBarang,
  }) : _getBarangPreviewUseCase = GetBarangPreviewUseCase(
      repository: barangRepository
  ) {
    pagingController.addPageRequestListener((pageNumber) {
        _pageRequestProcess = _processPageRequest(pageNumber);
    });
  }

  bool _isTryingRefresh = false;
  void tryRefreshPagination() async {
    if (!_isTryingRefresh){
      _isTryingRefresh = true;
      await _pageRequestProcess;
      if (canUseResource) { pagingController.refresh(); }
      _isTryingRefresh = false;
    }
  }

  Future<void> _pageRequestProcess = Future.value(null);
  Future<void> get pageRequestProcess =>
    _pageRequestProcess;
  Future<void> _processPageRequest(int pageNumber) async{
    final apiResponse = await _getBarangPreviewUseCase(
        pageNumber: pageNumber,
        keyword: searchBarangController.text,
    );

    if (!canUseResource){ return; }

    if (apiResponse is ApiResponseSuccess<List<BarangPreview>>){
      if (apiResponse.isNextDataExist){
        pagingController.appendPage(apiResponse.data!, pageNumber + 1);
      }
      else {
        pagingController.appendLastPage(apiResponse.data!);
        if (apiResponse.data?.length == 1 && pageNumber == 1){
          if (showBottomSheet != null) {
            showBottomSheet!(apiResponse.data!.first);
          }
        }
      }
    }
    else if (apiResponse is ApiResponseFailed){
      pagingController.error = Exception(apiResponse.error.toString());
    }
    else {
      throw Exception("Kesalahan di pilih barang provider");
    }
  }

  final pagingController = PagingController<int , BarangPreview>(firstPageKey: 1);

  final searchBarangController = TextEditingController();
  final searchBarangFocusNode = FocusNode();
  var _needRequestFocus = true;
  void tryRequestFocus(){
    if (_needRequestFocus){
      _needRequestFocus = false;
      searchBarangFocusNode.requestFocus();
    }
  }

  List<BarangTransaksi> choosenBarang = [];
  void addNewBarangTransaksi(final BarangTransaksi newBarangTransaksi){
    choosenBarang = [...choosenBarang , newBarangTransaksi];
    notifyListeners();
  }
  bool thisBarangAlreadyTaken(BarangPreview barang){
    return choosenBarang.any((element) => element.idBarang == barang.id);
  }

  @override
  void dispose(){
    searchBarangController.dispose();
    searchBarangFocusNode.dispose();
    pagingController.dispose();
    super.dispose();
  }
}