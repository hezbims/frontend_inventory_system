import 'dart:convert';

import 'package:fitur_input_pengajuan/domain/model/pengajuan.dart';

class SubmitPengajuanMapper {
  String fromPengajuanToJson(Pengajuan pengajuan){
    final jsonMap = {
      'id' : pengajuan.id,
      'id_pengaju' : pengajuan.pengaju!.id,
      'list_barang_ajuan' : pengajuan.listBarangTransaksi.map(
        (barangAjuan) => {
          'quantity' : barangAjuan.quantity,
          'keterangan' : barangAjuan.keterangan,
          'id_barang' : barangAjuan.idBarang,
        }
      ).toList(),
      'status_pengajuan': pengajuan.status?.name,
    };

    return jsonEncode(jsonMap);
  }
}