import 'package:common/data/repository/pengaju_repository_impl.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/component/pilih_pengaju/show_buat_pengaju_dialog.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/buat_pengaju_provider.dart';

class BuatPengajuDialogDependencySetup extends GetItDependencySetup {
  BuatPengajuDialogDependencySetup({
    required bool isPemasok,
    super.key,
  }) : super(
    setup: (){
      GetIt.I.registerSingleton(
        BuatPengajuProvider(
          repository: PengajuRepositoryImpl(),
          isPemasok: isPemasok,
        )
      );
    },
    disposeFunction: (){

    },
    page: const BuatPengajuBaruDialog(),
  );
}