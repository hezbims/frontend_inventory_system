import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_setting_akun/data/repository/setting_akun_repository_impl.dart';
import 'package:fitur_setting_akun/presentation/page/setting_akun_screen.dart';
import 'package:fitur_setting_akun/presentation/provider/setting_akun_provider.dart';

class SettingAkunPageDependencySetup extends GetItDependencySetup {
  SettingAkunPageDependencySetup() : super(
    setup: (){
      GetIt.I.registerSingleton(
        SettingAkunProvider(repository: SettingAkunRepositoryImpl()),
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<SettingAkunProvider>();
    },
    page: SettingAkunScreen(),
  );

}