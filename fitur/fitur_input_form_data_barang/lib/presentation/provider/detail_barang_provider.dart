import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class DetailBarangProvider extends ChangeNotifier {
  final IBarangRepository _repository;
  final int? idBarang;
  DetailBarangProvider({
    required IBarangRepository repository,
    required this.idBarang,
  }) : _repository = repository;

  Future<ApiResponse>? _getDetailBarangResponse;
  Future<ApiResponse> get getDetailBarangResponse {
    if (idBarang == null){
      return Future.value(ApiResponseSuccess(data: null));
    }

    return _getDetailBarangResponse ??= _repository.getDetailBarang(
      id: idBarang!
    );
  }

  void refresh(){
    _getDetailBarangResponse = null;
    notifyListeners();
  }
}