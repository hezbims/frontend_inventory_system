import 'package:common/response/api_response.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/repository/i_get_pengaju_repository.dart';

class FakeGroupRepository implements IGetPengajuRepository {
  final _groups = [
    Pengaju(nama: "D20-E3", id: 1),
    Pengaju(nama: "T3F", id: 2),
    Pengaju(nama: "24JPL", id: 3),
    Pengaju(nama: "B40003E420", id: 4),
    Pengaju(nama: "E65", id: 5),
    Pengaju(nama: "700G24", id: 6),
    Pengaju(nama: "T36JFG", id: 7),
    Pengaju(nama: "B1", id: 8),
    Pengaju(nama: "EVZ74G", id: 9),
  ];
  @override
  Future<ApiResponse> getPengaju(int isPemasok) {
    return Future.delayed(
      const Duration(milliseconds: 1500) ,
      () => ApiResponseSuccess(data : _groups),
    );
  }
}