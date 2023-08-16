import 'package:common/domain/model/kategori.dart';
import 'package:common/response/api_response.dart';
import 'package:common/domain/repository/i_kategori_repository.dart';

class FakeKategoriRepository implements IKategoriRepository {
  @override
  Future<ApiResponse> getAllKategori() {
    return Future.delayed(
      const Duration(seconds: 1) ,
      (){
        return ApiResponseSuccess(
            data : List.generate(
              10,
              (index) => Kategori(id: 3 , nama: "Barang rusak"),
            )
        );
      }
    );
  }

  @override
  Future<ApiResponse> addNewKategori(String newKategori) {
    // TODO: implement addNewKategori
    throw UnimplementedError();
  }

}