import 'package:common/data/repository/notification_repository_impl.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:common/utils/disposable_change_notifier.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class LihatPengajuanProvider extends DisposableChangeNotifier {
  final ILihatPengajuanRepository _repository;
  final INotificationRepository _notifRepo;
  LihatPengajuanProvider({
    required ILihatPengajuanRepository repository,
    INotificationRepository? notifRepo,
  }) :  _notifRepo = notifRepo ?? NotificationRepositoryImpl(),
        _repository = repository {
    pagingController.addPageRequestListener((pageNumber) {
      _pageRequestProcess = _requestPage(pageNumber);
    });
    _notifRepo.newPengajuanNotification().listen((event) {
      tryRefresh();
    });
  }

  final searchController = TextEditingController();

  final pagingController = PagingController<int , PengajuanPreview>(firstPageKey: 1);
  Future<void>? _pageRequestProcess;
  Future<void> _requestPage(int pageNumber) async {
    final response = await _repository.getPengajuanPreview(
      pageNumber: pageNumber,
      keyword: searchController.text,
      idPengaju: _filterPengaju?.id,
    );

    if (!canUseResource){
      return;
    }

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
  }
  bool _isRefreshing = false;
  void tryRefresh() async {
    if (!_isRefreshing){
      _isRefreshing = true;
      await _pageRequestProcess;
      if (canUseResource) {
        pagingController.refresh();
      }
      _isRefreshing = false;
    }
  }

  Pengaju? _filterPengaju;
  void setFilterPengaju(Pengaju? newFilterPengaju){
    if (newFilterPengaju?.id != _filterPengaju?.id){
      _filterPengaju = newFilterPengaju;
      tryRefresh();
    }
  }

  @override
  void dispose(){
    pagingController.dispose();
    searchController.dispose();
    super.dispose();
  }

}