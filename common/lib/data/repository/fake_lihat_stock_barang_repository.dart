import 'package:common/domain/model/kategori.dart';
import 'package:common/domain/model/rak.dart';
import 'package:common/response/api_response.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/repository/i_barang_repository.dart';

class FakeLihatStockBarangRepository implements IBarangRepository{
  final List<Barang> _listBarang = List.generate(
    15,
    (index){
      return Barang(
        id: "XG3024",
        nama: "Sarung Tangan Kain",
        minStock: 25,
        rak: Rak(nomorRak: 1, nomorLaci: 2, nomorKolom: 3),
        stockSekarang: 50,
        lastMonthStock: 36,
        unitPrice: 2000,
        kategori: Kategori(id: 1, nama: "Sarung Tangan"),
      );
    }
  );
  @override
  Future<ApiResponse> getStockBarang(int pageNumber) async {
    await Future.delayed(const Duration(seconds: 1));
    if (pageNumber == 4){
      return ApiResponseSuccess(data: _listBarang.sublist(0,4),);
    }
    else {
      return ApiResponseSuccess(
        data: _listBarang,
        isNextDataExist: true,
      );
    }
  }

}