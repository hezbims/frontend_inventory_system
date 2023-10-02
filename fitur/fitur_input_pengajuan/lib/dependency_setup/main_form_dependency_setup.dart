import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/data/repository/submit_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/presentation/pages/main_form.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';

class MainFormDependencySetup extends GetItDependencySetup {
  MainFormDependencySetup({
    required Pengajuan initialData,
    super.key,
  }) : super(
    setup: (){
      GetIt.I.registerSingleton(
        MainFormProvider(
          user: GetIt.I.get(),
          initialData: initialData,
          repository: SubmitPengajuanRepositoryImpl(),
        )
      );
    },
    disposeFunction: (){
      GetIt.I.unregister<MainFormProvider>();
    },
    page: const MainForm(),
  );
}