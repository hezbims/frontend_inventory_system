import 'package:common/data/api_client/inventory_system_http_client.dart';
import 'package:common/data/feature/transaction/repository/transaction_repository_impl.dart';
import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/data/repository/kategori_repository_impl.dart';
import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/data/service/environment_provider.dart';
import 'package:common/domain/feature/transaction/repository/i_transaction_repository.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/domain/repository/i_kategori_repository.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/domain/service/i_environment_provider.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_provider.dart';
import 'package:dependencies/get_it.dart';

void commonDi(){
  GetIt.I.registerSingleton(InventorySystemHttpClient());

  // Token Manager
  GetIt.I.registerSingleton<ITokenManager>(TokenManagerImpl());

  // Pengaju dependency
  GetIt.I.registerFactory<IPengajuRepository>(() => PengajuRepositoryImpl());

  // Barang dependency
  GetIt.I.registerFactory<IBarangRepository>(() => BarangRepositoryImpl());

  // Kategori dependency
  GetIt.I.registerFactory<IKategoriRepository>(() => KategoriRepositoryImpl());
  GetIt.I.registerFactory(
    () => KategoriDialogProvider(
      kategoriRepository: GetIt.I.get(),
    )
  );
  GetIt.I.registerFactory<ITransactionRepository>(() =>
      TransactionRepositoryImpl(httpClient: GetIt.I.get()));

  GetIt.I.registerFactory(
    () => PilihKategoriProvider(repository: GetIt.I.get())
  );

  GetIt.I.registerSingleton<IEnvironmentProvider>(EnvironmentProvider());
}