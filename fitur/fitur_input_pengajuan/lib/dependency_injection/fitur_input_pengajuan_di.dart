import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';

void fiturInputPengajuanDi(){
  GetIt.I.registerFactoryParam(
    (MainFormToPilihBarangArg arg, param2) => PilihBarangProvider(
      barangRepository: GetIt.I.get(),
      isPemasukan: arg.isPemasukan,
      choosenBarang: arg.initialList,
    ),
  );
}