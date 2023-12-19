import 'package:common/domain/repository/i_kategori_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class KategoriDialogProvider extends ChangeNotifier {
  final IKategoriRepository _kategoriRepository;
  KategoriDialogProvider({
    required IKategoriRepository kategoriRepository,
  }) : _kategoriRepository = kategoriRepository;

  String? _postKategoriError;
  String? get postKategoriError => _postKategoriError;

  ApiResponse? submitResponse;
  void submit(String namaKategori) async {
    if (submitResponse is! ApiResponseLoading) {
      submitResponse = ApiResponseLoading();
      notifyListeners();

      final response = await _kategoriRepository.addNewKategori(namaKategori);
      if (response is ApiResponseFailed) {
        _postKategoriError = response.error.toString();
      }
      submitResponse = response;
      notifyListeners();
    }
  }
}