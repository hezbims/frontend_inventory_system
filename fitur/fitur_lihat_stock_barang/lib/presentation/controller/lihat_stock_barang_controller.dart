import 'package:common/response/api_response.dart';
import 'package:dependencies/get.dart';
import 'package:fitur_lihat_stock_barang/domain/repository/i_stock_barang_repository.dart';

class LihatStockBarangController extends GetxController {
  final IStockBarangRepository _repository;
  LihatStockBarangController({
    required IStockBarangRepository repository,
  }) : _repository = repository , stockBarangApiResponse = repository.getAllStockBarang();

  Future<ApiResponse> stockBarangApiResponse;
  void refreshStockBarang(){
    stockBarangApiResponse = _repository.getAllStockBarang();
    update();
  }
}