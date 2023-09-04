import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';

void setupDI(){
  final getIt = GetIt.instance;
  getIt.registerSingleton<IBarangRepository>(BarangRepositoryImpl());
  getIt.registerSingleton<ITokenManager>(TokenManagerImpl());
  getIt.registerSingleton<ILoginRepository>(LoginRepositoryImpl());
}