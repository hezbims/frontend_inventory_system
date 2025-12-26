import 'package:dependencies/get_it.dart';
import 'package:fitur_auth_guard/data/repository/login_repository_impl.dart';
import 'package:fitur_auth_guard/domain/repository/i_login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_system/dependency_injection/setup_main_dependency_injection.dart';

void main(){
  setUp((){
    GetIt.I.reset();
    setupMainDependencyInjection();
  });

  tearDown((){
    GetIt.I.reset();
  });

  test("Auth dependency should registered correctly", (){
    final authRepository = GetIt.I.get<ILoginRepository>();

    expect(authRepository, isA<LoginRepositoryImpl>());
  });
}