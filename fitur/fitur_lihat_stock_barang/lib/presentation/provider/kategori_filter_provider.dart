import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/repository/i_kategori_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class KategoriFilterProvider extends ChangeNotifier {
  final IKategoriRepository _repository;
  KategoriFilterProvider({
    required IKategoriRepository repository,
  }) : _repository = repository;

  Future<ApiResponse>? _getKategoriResponse;
  Future<ApiResponse> get getKategoriResponse =>
    _getKategoriResponse ??= _repository.getAllKategori();
  void refresh(){
    _getKategoriResponse = null;
    notifyListeners();
  }

  static final Kategori _dummyKategori = Kategori(id: 0, nama: "-- Semua Kategori --");
  Kategori _choosenKategori = _dummyKategori;
  Kategori get choosenKategori => _choosenKategori;
  void setChoosenKategori(Kategori? newKategori){
    if (newKategori != null && newKategori.id != _choosenKategori.id){
      _choosenKategori = newKategori;
    }
  }

  List<Kategori> constructDropdownItems(List<Kategori> fromApi){
    return [_dummyKategori , ...fromApi];
  }
}