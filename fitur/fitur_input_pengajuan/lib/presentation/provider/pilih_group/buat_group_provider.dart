import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_create_pengaju_repository.dart';
import 'package:flutter/material.dart';

class BuatGroupProvider extends ChangeNotifier {
  final ICreatePengajuRepository _repository;
  final bool _isPemasok;
  BuatGroupProvider({
    required ICreatePengajuRepository repository,
    required bool isPemasok,
  }) : _repository = repository , _isPemasok = isPemasok;
  final emptyValidator = EmptyValidationUseCase();
  String? namaError;

  ApiResponse? submitResponse;
  void submit(String nama) async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      namaError =
          emptyValidator.validate(
            nama,
            fieldName: "Nama ${_isPemasok ? "pemasok" : "group"}"
          );
      notifyListeners();

      if (namaError == null) {
        submitResponse = await _repository.createPengaju(
          Pengaju(
            nama: nama,
            id: -1,
            isPemasok: _isPemasok,
          ),
        );

        if (submitResponse is ApiResponseFailed){
          Fluttertoast.showToast(
            msg: (submitResponse as ApiResponseFailed).error.toString()
          );
        }
      }
      else {
        submitResponse = null;
      }
      notifyListeners();
    }
  }
}