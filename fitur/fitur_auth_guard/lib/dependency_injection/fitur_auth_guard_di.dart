import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/data/api_client/login_api_client.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';

void fiturAuthGuardDi(){
  GetIt.I.registerFactory<ILoginRepository>(
    () => LoginRepositoryImpl(
      apiClient: LoginApiClient(),
      tokenManager: GetIt.I.get(),
    )
  );
  GetIt.I.registerFactory(() => LoginProvider(repository: GetIt.I.get()),);
}