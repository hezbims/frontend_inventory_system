import 'package:common/presentation/page_setup/page_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/data/repository/submit_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';

class InputDataPengajuanPageSetup extends PageSetup{
  InputDataPengajuanPageSetup() : super(
    setup: (){
      GetIt.I.registerSingleton<ISubmitPengajuanRepository>(SubmitPengajuanRepositoryImpl());
    },
    page: const InitialDetailPengajuanLoader()
  );
}