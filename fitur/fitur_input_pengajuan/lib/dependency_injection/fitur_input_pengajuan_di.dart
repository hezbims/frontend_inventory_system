import 'package:dependencies/get_it.dart';
import 'package:fitur_input_pengajuan/data/repository/submit_pengajuan_repository_impl.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_submit_pengajuan_repository.dart';
import 'package:fitur_input_pengajuan/presentation/arg_model/main_form_to_pilih_barang_arg.dart';
import 'package:fitur_input_pengajuan/presentation/provider/main_form/main_form_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/bottom_sheet_barang_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_barang/pilih_barang_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/buat_pengaju_provider.dart';
import 'package:fitur_input_pengajuan/presentation/provider/pilih_pengaju/pilih_pengaju_provider.dart';

void fiturInputPengajuanDi(){
  // Pilih Barang Dependency
  GetIt.I.registerFactoryParam(
    (MainFormToPilihBarangArg arg, param2) => PilihBarangProvider(
      barangRepository: GetIt.I.get(),
      isPemasukan: arg.isPemasukan,
      choosenBarang: arg.initialList,
    ),
  );

  // Main Form Dependency
  GetIt.I.registerFactory<ISubmitPengajuanRepository>(
    () => SubmitPengajuanRepositoryImpl()
  );
  GetIt.I.registerFactoryParam(
    (Pengajuan? initialData, param2) => MainFormProvider(
      user: GetIt.I.get(),
      initialData: initialData,
      repository: GetIt.I.get(),
    )
  );

  // Buat Pengaju Dialog Dependency
  GetIt.I.registerFactoryParam(
    (bool isPemasok, param2) =>
      BuatPengajuProvider(
        repository: GetIt.I.get(),
        isPemasok: isPemasok
      ),
  );

  // Pilih Pengaju Dependency
  GetIt.I.registerFactoryParam(
    (bool isPemasok , _) => PilihPengajuProvider(
      repository: GetIt.I.get(),
      isPemasok: isPemasok
    )
  );

  // Bottom Sheet Dependency Setup
  GetIt.I.registerFactoryParam(
    (BarangTransaksi initialData , _) =>
      BottomSheetBarangProvider(initialBarangTransaksi: initialData)
  );
}