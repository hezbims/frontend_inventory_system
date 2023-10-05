import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class FilterPengajuProvider extends ChangeNotifier {
  final IPengajuRepository _repository;
  FilterPengajuProvider({
    required IPengajuRepository repository
  }) : _repository = repository;

  String _tipePengaju = 'Group';
  String get tipePengaju => _tipePengaju;
  void onChangeTipeTransaksi(String? value) {
    if (value != null && value != _tipePengaju) {
      _tipePengaju = value;
      _pengajuDipilih = null;
      _getListPengajuResponse = null;
      notifyListeners();
    }
  }
  final listTipePengaju = [
    'Pemasok' , 'Group',
  ];

  Pengaju? _pengajuDipilih;
  Pengaju? get pengajuDipilih => _pengajuDipilih;
  void Function()? get onDeletePengajuDipilih {
    if (_pengajuDipilih != null) {
      return (){
        _pengajuDipilih = null;
        notifyListeners();
      };
    }
    return null;
  }
  void onChoosePengaju(Pengaju newPengaju){
    _pengajuDipilih = newPengaju;
    notifyListeners();
  }

  Future<ApiResponse>? _getListPengajuResponse;
  Future<ApiResponse> get getListPengajuResponse {
    return _getListPengajuResponse ??= _repository.getPengaju(
      tipePengaju == listTipePengaju[0],
    );
  }
  void refreshListPengaju(){
    _getListPengajuResponse = null;
    notifyListeners();
  }
  
}