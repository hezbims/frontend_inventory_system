import 'package:common/constant/url/common_url.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/http.dart';

class UserApiClient {
  final ITokenManager tokenManager = GetIt.I.get();
  Future<Response> getUser() async {
    final url = "${CommonUrl.baseUrl}/get-current-user";

    return get(
        Uri.parse(url),
        headers: await tokenManager.getTokenizedHeader()
    );
  }
}