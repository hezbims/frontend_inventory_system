import 'package:common/domain/feature/transaction/model/request/get_transactions_request.dart';
import 'package:dependencies_test_support/mocktail.dart';
import 'package:fitur_auth_guard/domain/model/post_login_dto.dart';

void registerMyAppFallbackValues(){
  // registerAuthFallbackValues();
  registerFallbackValue(PostLoginDto(password: '', username: ''));

  // registerTransactionFallbackValues();
  registerFallbackValue(GetTransactionsRequest());
}