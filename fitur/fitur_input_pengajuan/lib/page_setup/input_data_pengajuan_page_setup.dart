import 'package:common/presentation/dependency_setup/get_it_dependency_setup.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';

class InputDataPengajuanPageSetup extends GetItDependencySetup{
  InputDataPengajuanPageSetup({super.key}) : super(
    setup: (){
    },
    disposeFunction: (){
    },
    page: const InitialDetailPengajuanLoader()
  );
}