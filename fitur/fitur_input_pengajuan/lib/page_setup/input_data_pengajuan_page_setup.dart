import 'package:dependencies/get_it.dart';
import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:fitur_input_pengajuan/data/repository/submit_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';

class InputDataPengajuanPageSetup extends GetItDependencySetup{
  InputDataPengajuanPageSetup({super.key}) : super(
    setup: (){
      GetIt.I.registerSingleton<ISubmitPengajuanRepository>(SubmitPengajuanRepositoryImpl());
    },
    disposeFunction: (){
      GetIt.I.unregister<ISubmitPengajuanRepository>();
    },
    page: const InitialDetailPengajuanLoader()
  );
}