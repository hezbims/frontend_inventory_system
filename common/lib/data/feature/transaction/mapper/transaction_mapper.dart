import 'dart:convert';

import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';
import 'package:dependencies/http.dart';

abstract class TransactionMapper {
  static TransactionPreviews getTransactionPreviews(Response response){
    String responseBody = response.body;
    Map<String, dynamic> json = jsonDecode(responseBody);

    final data = json['data'].cast<Map<String , dynamic>>() as List<Map<String , dynamic>>;
    List<TransactionPreview> transactions = data.map((jsonTransactionPreview) =>
      getTransactionPreview(jsonTransactionPreview)
    ).toList();

    final int version = json['meta']['version'];
    final bool hasNextPage = json['meta']['has_next_page'];

    return TransactionPreviews(
      version: version,
      transactions: transactions,
      hasNextPage: hasNextPage,
    );
  }

  static TransactionPreview getTransactionPreview(Map<String, dynamic> json){
    return TransactionPreview(
      id: json['id'],
      stakeholderName: json['stakeholder']['name'],
      userName: json['user']['name'],
      transactionCode: json['transaction_code'],
      status: StatusPengajuan.from(json['status']),
      lastUpdate: json['updated_at'],
      isFromSupplier: json['stakeholder']['is_supplier']
    );
  }
}