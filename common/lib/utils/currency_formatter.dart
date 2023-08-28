import 'package:dependencies/intl.dart';

abstract class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: '',
  );

  static String toRupiah(int value){
    return _formatter.format(value);
  }
}