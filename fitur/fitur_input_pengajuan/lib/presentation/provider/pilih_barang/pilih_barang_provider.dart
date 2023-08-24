import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:flutter/material.dart';

class PilihBarangProvider extends ChangeNotifier {
  final IBarangRepository _barangRepository;
  final bool isPemasukan;

  PilihBarangProvider({
    required this.isPemasukan,
    required IBarangRepository barangRepository,
    required this.choosenBarang,
  }) : _barangRepository = barangRepository {
    pagingController.addPageRequestListener((pageNumber) {
        _pageReqestProcess = _processPageRequest(pageNumber);
    });
  }

  bool _isTryingRefresh = false;
  void tryRefresh() async {
    if (!_isTryingRefresh){
      _isTryingRefresh = true;
      await _pageReqestProcess;
      pagingController.refresh();
      _isTryingRefresh = false;
    }
  }

  Future<void>? _pageReqestProcess;
  Future<void> _processPageRequest(int pageNumber) async{
    final apiResponse = await _barangRepository.getStockBarang(
        pageNumber ,
        searchBarangController.text
    );

    if (apiResponse is ApiResponseSuccess<List<BarangPreview>>){
      if (apiResponse.isNextDataExist){
        pagingController.appendPage(apiResponse.data!, pageNumber + 1);
      }
      else {
        pagingController.appendLastPage(apiResponse.data!);
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
  void requestFocus(){
    if (_needRequestFocus){
      _needRequestFocus = false;
      searchBarangFocusNode.requestFocus();
    }
  }

  List<BarangTransaksi> choosenBarang = [];
  void addNewBarangTransaksi(final BarangTransaksi newBarangTransaksi){
    choosenBarang = [...choosenBarang , newBarangTransaksi];
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