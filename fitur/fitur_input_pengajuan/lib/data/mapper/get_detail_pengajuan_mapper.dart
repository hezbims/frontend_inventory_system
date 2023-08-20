import 'dart:convert';
import 'package:fitur_input_pengajuan/domain/model/barang_transaksi.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';
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
      tanggal: DateTime.parse(data['created_at']),
      pengaju: Pengaju(
        nama: data['pengaju']['nama'],
        id: data['pengaju']['id'],
      ),
      isPemasok: data['pengaju']['is_pemasok'] == 1,
      listBarangTransaksi: listBarangTransaksi,
    );
  }
}