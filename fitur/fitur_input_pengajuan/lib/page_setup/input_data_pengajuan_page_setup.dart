import 'package:common/presentation/page_setup/get_it_page_setup.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/data/repository/submit_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/pages/initial_detail_pengajuan_loader.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';

class InputDataPengajuanPageSetup extends GetItPageSetup{
  InputDataPengajuanPageSetup() : super(
    setup: (){
      GetIt.I.registerSingleton<ISubmitPengajuanRepository>(SubmitPengajuanRepositoryImpl());
      GetIt.I.registerSingleton(BottomSheetBarangProvider());
    },
    disposeFunction: (){
      GetIt.I.unregister<ISubmitPengajuanRepository>();
      GetIt.I.unregister<BottomSheetBarangProvider>();
    },
    page: const InitialDetailPengajuanLoader()
  );
}