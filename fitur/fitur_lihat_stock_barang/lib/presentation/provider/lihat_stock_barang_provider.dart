import 'package:common/response/api_response.dart';
import 'package:common/domain/repository/i_stock_barang_repository.dart';
import 'package:flutter/material.dart';

class LihatStockBarangProvider extends ChangeNotifier {
  final IStockBarangRepository _repository;
  LihatStockBarangProvider({
    required IStockBarangRepository repository,
  }) : _repository = repository , stockBarangApiResponse = repository.getAllStockBarang();

  Future<ApiResponse> stockBarangApiResponse;
  void refreshStockBarang(){
    stockBarangApiResponse = _repository.getAllStockBarang();
    notifyListeners();
  }
}