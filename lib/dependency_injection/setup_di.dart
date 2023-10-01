import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/data/repository/user_repository_impl.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:dependencies/get_it.dart';

void setupMainDependencyInjection(){
  final getIt = GetIt.instance;
  getIt.registerSingleton<IBarangRepository>(BarangRepositoryImpl());
  getIt.registerSingleton<ITokenManager>(TokenManagerImpl());
  getIt.registerSingleton(UserProvider(repository: UserRepositoryImpl()));
}