import 'package:common/constant/enums/status_pengajuan.dart';

class TransactionPreviews {
  final int version;
  final bool hasNextPage;
  final List<TransactionPreview> transactions;
  TransactionPreviews({
    required this.version,
    required this.transactions,
    required this.hasNextPage,
  });
}

class TransactionPreview {
  final int id;
  final String stakeholderName;
  /// Kalau user name tidak ada, maka ini adalah pemasukan
  final String? userName;
  final String transactionCode;
  final StatusPengajuan status;
  final int lastUpdate;

  TransactionPreview({
    required this.id,
    required this.stakeholderName,
    required this.userName,
    required this.transactionCode,
    required this.status,
    required this.lastUpdate,
  });
}