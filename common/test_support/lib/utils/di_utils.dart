import 'package:dependencies/get_it.dart';

/// Dependency injection utils
abstract class DiUtils {
  static void overrideWithSingleton<T extends Object>(T newDependency){
    if (GetIt.I.isRegistered<T>()) GetIt.I.unregister<T>();

    GetIt.I.registerSingleton(newDependency);
  }
}