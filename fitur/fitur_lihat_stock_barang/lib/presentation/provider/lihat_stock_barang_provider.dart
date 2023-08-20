import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_stock_barang/domain/use_case/get_barang_paginate_use_case.dart';
import 'package:flutter/material.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';

class LihatStockBarangProvider extends ChangeNotifier {
  final GetBarangPaginateUseCase _barangPaginator;
  LihatStockBarangProvider({
    required IBarangRepository repository,
  }) : _barangPaginator = GetBarangPaginateUseCase(repository: repository) {
    pagingController.addPageRequestListener((pageNumber) async {
      try {
        final apiResponse = await _barangPaginator.fetch(
          pageNumber: pageNumber,);
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
    });
  }

  final PagingController<int , Barang> pagingController = PagingController(firstPageKey: 1);
  void refresh(){
    pagingController.refresh();
    notifyListeners();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

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