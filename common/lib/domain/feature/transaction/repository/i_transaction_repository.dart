import 'package:common/domain/feature/transaction/model/request/get_transactions_request.dart';
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';
import 'package:common/domain/model/response_wrapper.dart';

abstract class ITransactionRepository {
  Future<ResponseWrapper<TransactionPreviews, Object>> getTransactionPreviews({
    required final GetTransactionsRequest request
  });
}