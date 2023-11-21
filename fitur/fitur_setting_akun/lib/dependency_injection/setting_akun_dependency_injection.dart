import 'package:dependencies/get_it.dart';
import 'package:fitur_setting_akun/data/repository/setting_akun_repository_impl.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';

void settingAkunDependencyInjection(){
  GetIt.I.registerFactory(
    () => SettingAkunProvider(
      repository: SettingAkunRepositoryImpl()
    ),
  );
}