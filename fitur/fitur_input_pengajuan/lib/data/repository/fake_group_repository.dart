import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_get_pengaju_repository.dart';

class FakeGroupRepository implements IGetPengajuRepository {
  final _groups = [
    Pengaju(nama: "D20-E3", id: 1 , isPemasok: true),
    Pengaju(nama: "T3F", id: 2 , isPemasok: true),
    Pengaju(nama: "24JPL", id: 3 , isPemasok: true),
    Pengaju(nama: "B40003E420", id: 4 , isPemasok: true),
    Pengaju(nama: "E65", id: 5, isPemasok: false),
    Pengaju(nama: "700G24", id: 6, isPemasok: false),
    Pengaju(nama: "T36JFG", id: 7, isPemasok: false),
    Pengaju(nama: "B1", id: 8, isPemasok: false),
    Pengaju(nama: "EVZ74G", id: 9, isPemasok: false),
  ];
  @override
  Future<ApiResponse> getPengaju(bool isPemasok) {
    return Future.delayed(
      const Duration(milliseconds: 1500) ,
      () => ApiResponseSuccess(data : _groups),
    );
  }
}