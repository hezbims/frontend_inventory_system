import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';
import 'package:fitur_auth_guard/presentation/page/login_screen.dart';
import 'package:fitur_auth_guard/presentation/provider/login_provider.dart';

class LoginDependencySetup extends GetItDependencySetup {
  LoginDependencySetup() : super(
    setup: (){
      GetIt.I.registerSingleton<ILoginRepository>(LoginRepositoryImpl());
      GetIt.I.registerSingleton(LoginProvider());
    },
    disposeFunction: (){
      GetIt.I.unregister<ILoginRepository>();
      GetIt.I.unregister<LoginProvider>();
    },
    page: LoginScreen(),
  );

}