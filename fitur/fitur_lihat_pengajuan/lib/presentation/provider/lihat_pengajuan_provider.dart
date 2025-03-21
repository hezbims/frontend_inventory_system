import 'dart:async';

import 'package:common/domain/feature/transaction/model/request/get_transactions_request.dart';
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';
import 'package:common/domain/feature/transaction/repository/i_transaction_repository.dart';
import 'package:common/domain/helper/my_debouncer_helper.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:common/domain/model/response_wrapper.dart';
import 'package:common/presentation/pagination/page_event.dart';
import 'package:common/utils/disposable_change_notifier.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';
import 'package:fitur_lihat_pengajuan/presentation/model/transaction_page_item.dart';

class LihatPengajuanProvider extends DisposableChangeNotifier {
  final ITransactionRepository _transactionRepo;
  final INotificationRepository _notifRepo;

  bool _isFirstPage = true;
  int _currentClientPengajuanDataVersion = -1;
  int _currentServerPengajuanDataVersion = -1;
  bool get shouldDisplayRefreshToast =>
    !_isFirstPage &&
    (_currentClientPengajuanDataVersion != _currentServerPengajuanDataVersion);

  StreamSubscription<int>? _notifSubscription;

  final _debouncer = MyLatestQueueDebouncerHelper();

  LihatPengajuanProvider({
    required ITransactionRepository transactionRepo,
    required INotificationRepository notifRepo,
  }) :  _notifRepo = notifRepo,
        _transactionRepo = transactionRepo {
    _notifSubscription = _notifRepo.getSseTransaction().listen((transactionsVersion){
      if (_currentServerPengajuanDataVersion == transactionsVersion){
        return;
      }
      _currentServerPengajuanDataVersion = transactionsVersion;
    });
  }

  void fetchTransactionPage(GetTransactionsRequest _){
    _debouncer.run(process: () async {
      final transactionResponse = await _transactionRepo
          .getTransactionPreviews(request: request);
      switch(transactionResponse){
        case ResponseSucceed<TransactionPreviews, Object>():
          _currentClientPengajuanDataVersion = transactionResponse.data.version;
          final List<TransactionPageItem> pageItems = [];
          final isLast = !transactionResponse.data.hasNextPage;

          if (_isFirstPage){
            pageItems.add(HeaderItem());
          }

          final Iterable<DataItem> transactionDatas = transactionResponse
            .data.transactions.map((transaction) => DataItem(transaction));
          final TransactionPreview? lastTransaction = transactionDatas.lastOrNull?.data;

          pageItems.addAll(transactionDatas);
          
          _pageEvent = PageDataArrive(data: pageItems, isLast: isLast);
          _isFirstPage = false;

          if (lastTransaction != null) {
            _request.setNextPageKey(
              lastUpdate: lastTransaction.lastUpdate,
              lastId: lastTransaction.id);
          }

          tryNotifyListener();
          break;
        case ResponseFailed<TransactionPreviews, Object>():
          _pageEvent = PageError(transactionResponse.message);
          tryNotifyListener();
          break;
        case ResponseLoading<TransactionPreviews, Object>():
          throw Exception("Tidak mungkin");
      }
    });
  }

  PageEvent<List<TransactionPageItem>>? _pageEvent;
  PageEvent<List<TransactionPageItem>>? get pageEvent => _pageEvent;
  final GetTransactionsRequest _request = GetTransactionsRequest();
  GetTransactionsRequest get request => _request;

  void tryRefresh(){
    _debouncer.run(process: () async {
      _isFirstPage = true;
      _pageEvent = PageRefreshRequest();
      tryNotifyListener();
    });
  }

  void doneHandlingPageEvent(){
    _pageEvent = null;
  }

  void tryNotifyListener(){
    try { notifyListeners(); } catch (_) {}
  }

  void setNewSearchKeyword(String newSearchKeyword){
    if (
      newSearchKeyword.length > 2 || _request.searchKeyword.length > 2
    ) {
      _request.setSearchKeyword(newSearchKeyword);
      tryRefresh();
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
  void dispose() async {
    await _notifSubscription?.cancel();
    _notifRepo.dispose();
    super.dispose();
  }

}