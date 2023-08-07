import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_stock_barang/domain/model/barang.dart';
import 'package:fitur_lihat_stock_barang/domain/repository/i_stock_barang_repository.dart';

class FakeLihatStockBarangRepository implements IStockBarangRepository{
  final List<Barang> _listBarang = List.generate(
    10,
    (index){
      return Barang(
        id: "XG3024",
        nama: "Sarung Tangan Kain",
        minStock: 25,
        nomorRak: "C203",
        stockSekarang: 50,
        lastMonthStock: 36,
        unitPrice: 2000,
        category: "Sarung Tangan",
      );
    }
  );
  @override
  Future<ApiResponse> getAllStockBarang() async {
    await Future.delayed(const Duration(seconds: 2));
    return ApiResponseSuccess(data: _listBarang);
  }

}