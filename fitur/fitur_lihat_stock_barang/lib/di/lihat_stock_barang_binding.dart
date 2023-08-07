import 'package:dependencies/get.dart';
import 'package:fitur_lihat_stock_barang/data/repository/fake_lihat_stock_barang_repository.dart';
import 'package:fitur_lihat_stock_barang/presentation/controller/lihat_stock_barang_controller.dart';

class LihatStockBarangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      LihatStockBarangController(
        repository: FakeLihatStockBarangRepository(),
      )
    );
  }

}