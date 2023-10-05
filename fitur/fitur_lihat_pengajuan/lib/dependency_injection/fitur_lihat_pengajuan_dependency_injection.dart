import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';

void fiturLihatPengajuanDependencyInjection(){
  GetIt.I.registerFactory(
    () => FilterPengajuProvider(repository: GetIt.I.get()),
  );
}