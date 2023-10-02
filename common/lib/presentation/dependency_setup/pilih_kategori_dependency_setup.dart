import 'package:common/data/repository/kategori_repository_impl.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_page.dart';
import 'package:common/presentation/page/pilih_kategori/pilih_kategori_provider.dart';
import 'package:dependencies/get_it.dart';

class PilihKategoriDependencySetup extends GetItDependencySetup {
  PilihKategoriDependencySetup({super.key}) : super(
    setup: (){
      GetIt.I.registerSingleton(
        PilihKategoriProvider(
          repository: KategoriRepositoryImpl(),
        ),
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<PilihKategoriProvider>();
    },
    page: const PilihKategoriPage(),
  );
}