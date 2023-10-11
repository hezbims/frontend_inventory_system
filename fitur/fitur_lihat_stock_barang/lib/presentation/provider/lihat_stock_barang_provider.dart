import 'dart:async';

import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:common/utils/disposable_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';

class LihatStockBarangProvider extends DisposableChangeNotifier {
  final IBarangRepository _repository;
  LihatStockBarangProvider({
    required IBarangRepository repository,
  }) : _repository = repository {
    pagingController.addPageRequestListener(_performApiCall);
  }

  void tryApiCall() async {
    // make sure api call ini cuma dipanggil sekali aja,
    // karena tryApiCall ini asynchronous, ada kemungkinan _waitListener dipanggil
    // berkali-kali kalo gak ada penanda proses tryApiCall() udah selesai atau belum
    if (!_isTryApiCall) {
      _isTryApiCall = true;
      await _waitListener();
      if (canUseResource) {
        pagingController.refresh();
      }
      _isTryApiCall = false;
    }
  }

  Future<void> _waitListener() async {
    while (_listenerIsProcessing){
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  bool _isTryApiCall = false;
  bool _listenerIsProcessing = false;

  void _performApiCall(int pageNumber) async {
    _listenerIsProcessing = true;
    try {
      final apiResponse = await _repository.getStockBarang(
        pageNumber, namaController.text,
      );

      if (apiResponse is ApiResponseSuccess<List<Barang>>) {
        if (apiResponse.isNextDataExist) {
          pagingController.appendPage(
            apiResponse.data!,
            pageNumber + 1,
          );
        }
        else {
          pagingController.appendLastPage(apiResponse.data!);
        }
      }
      else if (apiResponse is ApiResponseFailed) {
        pagingController.error = Exception(
          apiResponse.error,
        );
      }
      else {
        throw Exception("Error di lihat stock barang");
      }
    } catch (e) {
      debugPrint("Error di paging controller : $e");
    }
    _listenerIsProcessing = false;
  }

  final PagingController<int , Barang> pagingController = PagingController(firstPageKey: 1);

  final namaController = TextEditingController();
  Kategori? _kategori;
  Kategori? get kategori => _kategori;
  void onKategoriChange(Kategori? value) {
    if (value != null) {
      _kategori = value;
      notifyListeners();
    }
  }

  String _nomorRak = "Semua";
  String get nomorRak => _nomorRak;
  void onNomorRakChange(String? value) {
    if (value != null) {
      _nomorRak = value;
    }
  }

  @override
  void dispose(){
    namaController.dispose();
    pagingController.dispose();
    super.dispose();
  }
}