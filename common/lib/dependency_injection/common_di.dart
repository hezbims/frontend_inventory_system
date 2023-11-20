import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/data/repository/kategori_repository_impl.dart';
import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/data/repository/token_manager.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/domain/repository/i_kategori_repository.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:common/domain/repository/i_token_manager.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_provider.dart';
import 'package:dependencies/get_it.dart';

void commonDi(){
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
  GetIt.I.registerFactory(
    () => PilihKategoriProvider(repository: GetIt.I.get())
  );
}