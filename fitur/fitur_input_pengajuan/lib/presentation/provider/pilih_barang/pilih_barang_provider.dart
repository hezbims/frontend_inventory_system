import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/use_case/get_filtered_barang_use_case.dart';
import 'package:flutter/material.dart';

class PilihBarangProvider extends ChangeNotifier {
  final IBarangRepository _barangRepository;
  final _getFilteredBarangUseCase = GetFilteredBarangFromApiUseCase();

  PilihBarangProvider({
    required IBarangRepository barangRepository,
  }) : _barangRepository = barangRepository {
    searchBarangController.addListener(notifyListeners);
  }

  Future<ApiResponse>? _allBarangResponse;
  Future<ApiResponse> _getAllBarangResponse() {
    _allBarangResponse ??= _barangRepository.getStockBarang(1);
    return _allBarangResponse!;
  }
  void onRefreshStockBarang(){
    _allBarangResponse = _barangRepository.getStockBarang(1);
    notifyListeners();
  }

  Future<ApiResponse> get filteredBarangResponse =>
      _getFilteredBarangUseCase.get(
          future: _getAllBarangResponse(),
          keyword: searchBarangController.text
      );

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
    choosenBarang.add(newBarangTransaksi);
  }

  @override
  void dispose(){
    searchBarangController.dispose();
    searchBarangFocusNode.dispose();
    super.dispose();
  }
}