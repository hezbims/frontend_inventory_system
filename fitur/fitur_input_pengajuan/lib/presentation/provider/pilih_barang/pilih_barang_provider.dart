import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:flutter/material.dart';

class PilihBarangProvider extends ChangeNotifier {
  final IBarangRepository _barangRepository;

  PilihBarangProvider({
    required IBarangRepository barangRepository,
    required this.choosenBarang,
  }) : _barangRepository = barangRepository {
    pagingController.addPageRequestListener((pageNumber) async {
      final apiResponse = await _barangRepository.getStockBarang(
        pageNumber ,
        searchBarangController.text
      );

      if (apiResponse is ApiResponseSuccess<List<BarangPreview>>){
        if (apiResponse.isNextDataExist){
          pagingController.appendPage(apiResponse.data!, pageNumber + 1);
        }
        else {
          pagingController.appendLastPage(apiResponse.data!);
        }
      }
      else if (apiResponse is ApiResponseFailed){
        debugPrint("masuk apiresponse failed : ${apiResponse.error.toString()}");
        pagingController.error = Exception(apiResponse.error.toString());
      }
      else {
        debugPrint((apiResponse as ApiResponseSuccess).data.runtimeType.toString());
        throw Exception("Kesalahan di pilih barang provider");
      }
    });
  }

  final pagingController = PagingController<int , BarangPreview>(firstPageKey: 1);

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
  bool thisBarangAlreadyTaken(BarangPreview barang){
    return choosenBarang.any((element) => element.idBarang == barang.id);
  }

  @override
  void dispose(){
    searchBarangController.dispose();
    searchBarangFocusNode.dispose();
    pagingController.dispose();
    super.dispose();
  }
}