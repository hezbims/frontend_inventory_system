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

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final namaController = TextEditingController();
  String _kategori = "Semua";
  String get kategori => _kategori;
  void onKategoriChange(String? value) {
    if (value != null) {
      _kategori = value;
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

    super.dispose();
  }
}