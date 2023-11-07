import 'dart:convert';
import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:common/domain/model/pengaju.dart';
import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';

class GetDetailPengajuanMapper {
  Pengajuan fromBodyToDetailPengajuan(String body){
    final jsonBody = jsonDecode(body);

    final data = jsonBody['data'];
    final List<BarangTransaksi> listBarangTransaksi = data['list_barang'].map(
      (json){
        return BarangTransaksi(
          id: json['id'],
          idBarang: json['barang']['id'],
          namaBarang: json['barang']['nama'],
          quantity: json['quantity'],
          keterangan: json['keterangan'] ?? ""
        );
      }
    ).toList().cast<BarangTransaksi>();

    return Pengajuan(
      id: data['id'],
      tanggal: DateTime.fromMillisecondsSinceEpoch(
        data['created_at'],
      ),
      pengaju: Pengaju(
        nama: data['pengaju']['nama'],
        id: data['pengaju']['id'],
        isPemasok: data['pengaju']['is_pemasok'] == 1,
      ),
      status: StatusPengajuan.from(data['status']),
      listBarangTransaksi: listBarangTransaksi,
    );
  }
}