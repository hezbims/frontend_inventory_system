import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class LihatPengajuanProvider extends ChangeNotifier {
  final ILihatPengajuanRepository _repository;
  LihatPengajuanProvider({
    required ILihatPengajuanRepository repository,
  }) : _repository = repository,
      getAllPengajuanResponse = repository.getAllPengajuan();

  Future<ApiResponse> getAllPengajuanResponse;
  void refreshData(){
    getAllPengajuanResponse = _repository.getAllPengajuan();
    notifyListeners();
  }
}