import 'package:common/data/repository/barang_repository_impl.dart';
import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/domain/repository/i_barang_repository.dart';
import 'package:common/domain/repository/i_pengaju_repository.dart';
import 'package:dependencies/get_it.dart';

void commonDi(){
  GetIt.I.registerFactory<IPengajuRepository>(() => PengajuRepositoryImpl());
  GetIt.I.registerFactory<IBarangRepository>(() => BarangRepositoryImpl());
}