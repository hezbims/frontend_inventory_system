import 'package:common/data/repository/token_manager.dart';
import 'package:common/data/repository/user_repository_impl.dart';
import 'package:common/dependency_injection/common_di.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/presentation/provider/user_provider.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/dependency_injection/fitur_input_pengajuan_di.dart';
import 'package:fitur_lihat_stock_barang/dependency_injection/fitur_lihat_stock_barang_di.dart';

void setupMainDependencyInjection(){
  final getIt = GetIt.instance;
  commonDi();
  fiturInputPengajuanDi();
  fiturLihatStockBarangDi();
  getIt.registerSingleton<ITokenManager>(TokenManagerImpl());
  getIt.registerSingleton(UserProvider(repository: UserRepositoryImpl()));
}