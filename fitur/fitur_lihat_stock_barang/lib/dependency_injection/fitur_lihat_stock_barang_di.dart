import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';

void fiturLihatStockBarangDi(){
  GetIt.I.registerFactory(
    () => LihatStockBarangProvider(
      repository: GetIt.I.get(),
    ),
  );
}