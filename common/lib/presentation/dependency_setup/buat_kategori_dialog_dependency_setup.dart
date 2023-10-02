import 'package:common/data/repository/kategori_repository_impl.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog.dart';
import 'package:common/presentation/dialog/kategori_dialog/kategori_dialog_provider.dart';
import 'package:dependencies/get_it.dart';

class BuatKategoriDialogDependencySetup extends GetItDependencySetup {
  BuatKategoriDialogDependencySetup({super.key}) :
    super(
      setup: (){
        GetIt.I.registerSingleton(
          KategoriDialogProvider(
            kategoriRepository: KategoriRepositoryImpl(),
          ),
        );
      },
      disposeFunction: (){
        GetIt.I.unregister<KategoriDialogProvider>();
      },
      page: const KategoriDialog(),
    );

}