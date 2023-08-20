import 'package:common/response/api_response.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class LihatPengajuanProvider extends ChangeNotifier {
  final ILihatPengajuanRepository _repository;
  LihatPengajuanProvider({
    required ILihatPengajuanRepository repository,
  }) : _repository = repository {
    pagingController.addPageRequestListener((pageNumber) async {
      final response = await _repository.getPengajuanPreview(pageNumber);

      if (response is ApiResponseSuccess){
        if (response.isNextDataExist){
          pagingController.appendPage(response.data, pageNumber + 1);
        }
        else {
          pagingController.appendLastPage(response.data);
        }
      }
      else if (response is ApiResponseFailed){
        pagingController.error = Exception(response.error);
      }
      else {
        throw Exception("Enggak mungkin");
      }
    });
  }

  final pagingController = PagingController<int , PengajuanPreview>(firstPageKey: 1);

  @override
  void dispose(){
    pagingController.dispose();
    super.dispose();
  }

}