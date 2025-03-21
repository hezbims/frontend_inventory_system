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
  Future<ResponseWrapper<TransactionPreviews, Object>> getTransactionPreviews({
      required final GetTransactionsRequest request
  }) async {
    String endpoint = "pengajuan?";
    if (request.lastId != null) {
      endpoint += "last_id=${request.lastId}&";
    }
    if (request.lastUpdate != null) {
      endpoint += "last_update=${request.lastUpdate}&";
    }

    return ApiRequestProcessor.processV2(
        apiRequest: _httpClient.doRequest(
          method: HttpMethod.get,
          endpoint: endpoint,
        ),
        getModelFromBody: TransactionMapper.getTransactionPreviews
    );
  }
}