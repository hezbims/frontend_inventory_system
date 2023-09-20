import 'package:common/data/repository/notification_repository_impl.dart';
import 'package:common/domain/repository/i_notification_repository.dart';
import 'package:common/response/api_response.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';
import 'package:flutter/material.dart';

class LihatPengajuanProvider extends ChangeNotifier {
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
    );

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
      pagingController.refresh();
      _isRefreshing = false;
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    pagingController.dispose();
    searchController.dispose();
    super.dispose();
  }

}