import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_get_detail_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class GetDetailPengajuanProvider extends ChangeNotifier {
  final int? _id;
  final IGetDetailPengajuanRepository _repository;

  GetDetailPengajuanProvider({
    required int? id,
    required IGetDetailPengajuanRepository repository,
  }) : _repository = repository, _id = id;

  Future<ApiResponse>? _getDetailPengajuanResponse;
  Future<ApiResponse> getDetailPengajuanResponse(){
    if (_id == null){
      return Future.value(
        ApiResponseSuccess(
          data: Pengajuan(
            id: null,
            tanggal: DateTime.now(),
            pengaju: null,
            status: null,
          )
        )
      );
    }
    return _getDetailPengajuanResponse ??= _repository.getDetailPengajuan(_id!);
  }

  void refresh(){
    _getDetailPengajuanResponse = _repository.getDetailPengajuan(_id!);
    notifyListeners();
  }
}