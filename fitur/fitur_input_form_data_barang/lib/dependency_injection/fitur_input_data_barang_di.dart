import 'package:common/domain/model/barang.dart';
import 'package:dependencies/get_it.dart';
import 'package:fitur_input_form_data_barang/data/repository/submit_barang_repository_impl.dart';
import 'package:fitur_input_form_data_barang/domain/repository/i_submit_barang_repository.dart';
import 'package:fitur_input_form_data_barang/presentation/provider/detail_barang_provider.dart';
import 'package:fitur_input_form_data_barang/presentation/provider/input_data_barang_provider.dart';

void fiturInputDataBarangDI(){
  GetIt.I.registerFactory<ISubmitBarangRepository>(
    () => SubmitBarangRepositoryImpl(),
  );

  GetIt.I.registerFactoryParam(
    (int? idBarang , _) => DetailBarangProvider(
      repository: GetIt.I.get(),
      idBarang: idBarang,
    ),
  );

  GetIt.I.registerFactoryParam(
    (Barang? arg , _) =>
      InputDataBarangProvider(
        initialData: arg,
        repository: GetIt.I.get(),
      )
  );
}