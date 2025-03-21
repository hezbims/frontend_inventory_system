import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_pengajuan/data/repository/notification_repository_impl.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_notification_repository.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';

void fiturLihatPengajuanDependencyInjection(){
  GetIt.I.registerFactory<INotificationRepository>(
    () => NotificationRepositoryImpl(),
  );
  GetIt.I.registerFactory(
    () => LihatPengajuanProvider(
      transactionRepo: GetIt.I.get(),
      notifRepo: GetIt.I.get(),
    ),
  );

  GetIt.I.registerFactory(
    () => FilterPengajuProvider(repository: GetIt.I.get()),
  );
}