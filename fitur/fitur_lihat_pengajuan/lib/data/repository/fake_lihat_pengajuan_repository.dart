import 'package:common/domain/model/pengajuan.dart';
import 'package:common/domain/model/transaksi.dart';
import 'package:common/response/api_response.dart';
import 'package:fitur_lihat_pengajuan/domain/repository/i_lihat_pengajuan_repository.dart';

class FakeLihatPengajuanRepository implements ILihatPengajuanRepository {
  final List<Pengajuan> _listPengajuan = List.generate(10, (index) {
    return Pengajuan(
        id: 1,
        nama: "PT Sarung Tangan Sejahtera",
        tanggal: "12 Jan 2021",
        jam: "19.30",
        section: null,
        tipe: "Pemasukan",
        listTransaksi: List.generate(6, (index) {
          return Transaksi(
            id: index,
            idBarang: index,
            idPengajuan: 1,
            quantity: 4
          );
        }),
    );
  });

  @override
  Future<ApiResponse> getAllPengajuan() {
    return Future.delayed(const Duration(seconds: 2) , (){
      return ApiResponseSuccess(data : _listPengajuan);
    });
  }

}