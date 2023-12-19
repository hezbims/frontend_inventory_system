import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:common/domain/use_cases/empty_validation_use_case.dart';
import 'package:common/response/api_response.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:flutter/material.dart';

class BuatPengajuProvider extends ChangeNotifier {
  final IPengajuRepository _repository;
  final bool isPemasok;
  BuatPengajuProvider({
    required IPengajuRepository repository,
    required this.isPemasok,
  }) : _repository = repository;
  final emptyValidator = EmptyValidationUseCase();
  String? namaError;

  ApiResponse? submitResponse;
  void submit(String nama) async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      namaError =
          emptyValidator.validate(
            nama,
            fieldName: "Nama ${isPemasok ? "pemasok" : "group"}"
          );
      notifyListeners();

      if (namaError == null) {
        submitResponse = await _repository.createPengaju(
          Pengaju(
            nama: nama,
            id: -1,
            isPemasok: isPemasok,
          ),
        );

        if (submitResponse is ApiResponseFailed){
          namaError = (submitResponse as ApiResponseFailed).error.toString();
        }
      }
      else {
        submitResponse = null;
      }
      notifyListeners();
    }
  }
}