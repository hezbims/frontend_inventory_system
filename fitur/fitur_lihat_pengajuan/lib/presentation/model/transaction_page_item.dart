
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';

sealed class TransactionPageItem {}

class HeaderItem extends TransactionPageItem {}

class DataItem extends TransactionPageItem {
  final TransactionPreview data;
  DataItem(this.data);
}