import 'package:dependencies/get_it.dart';
import 'package:fitur_lihat_stock_barang/domain/use_case/get_preview_stock_barang.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/kategori_filter_provider.dart';
import 'package:fitur_lihat_stock_barang/presentation/provider/lihat_stock_barang_provider.dart';

void fiturLihatStockBarangDi(){
  GetIt.I.registerFactory(
    () => GetPreviewStockBarang(repository: GetIt.I.get())
  );

  GetIt.I.registerFactory(
    () => LihatStockBarangProvider(
      getPreviewStockBarang: GetIt.I.get(),
    ),
  );

  GetIt.I.registerFactory(
    () => KategoriFilterProvider(
      repository: GetIt.I.get(),
    ),
  );
}