import 'package:dependencies/get_it.dart';
import 'package:fitur_input_barang_by_csv/presentation/input_barang_by_csv_provider.dart';

void inputBarangByCsvDi(){
  GetIt.I.registerFactory(
    () => InputBarangByCsvProvider(repository: GetIt.I.get()),
  );
}