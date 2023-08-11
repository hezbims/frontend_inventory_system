import 'package:common/domain/model/barang.dart';

class FilterBarangByKeywordUseCase {
  List<Barang> filter({
    required List<Barang> data,
    required String keyword,
  }){
    return data.where(
      (dataBarang){
        return dataBarang.nama.toLowerCase().contains(
          keyword.toLowerCase()
        );
    }
    ).toList();
  }
}