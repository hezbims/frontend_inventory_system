import 'dart:collection';

import 'package:common/data/api_client/inventory_system_http_client.dart';
import 'package:common/data/api_request_proccessor/api_request_proccessor.dart';
import 'package:common/data/feature/transaction/mapper/transaction_mapper.dart';
import 'package:common/domain/feature/transaction/model/request/get_transactions_request.dart';
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';
import 'package:common/domain/feature/transaction/repository/i_transaction_repository.dart';
import 'package:common/domain/model/response_wrapper.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final InventorySystemHttpClient _httpClient;

  TransactionRepositoryImpl({
    required InventorySystemHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<ResponseWrapper<TransactionPreviews, Object?>> getTransactionPreviews({
      required final GetTransactionsRequest request
  }) async {
    final Map<String, String?> queryParams = HashMap();
    if (request.lastId != null) {
      queryParams["last_id"] = request.lastId.toString();
    }
    if (request.lastUpdate != null) {
      queryParams["last_date"] = request.lastUpdate.toString();
    }
    if (request.searchKeyword.length  > 2){
      queryParams["search_keyword"] = request.searchKeyword.toString();
    }
    Uri uri = Uri(path: "pengajuan", queryParameters: queryParams);

    return ApiRequestProcessor.processV2(
        apiRequest: _httpClient.doRequest(
          method: HttpMethod.get,
          endpoint: uri.toString(),
        ),
        getModelFromBody: TransactionMapper.getTransactionPreviews
    );
  }
}