import 'dart:convert';

import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';

class PengajuanPreviewMapper {
  List<PengajuanPreview> fromBodyToPengajuanPreview(String body){
    final jsonBody = jsonDecode(body);

    final List<Map<String , dynamic>> data =
      jsonBody['data'].cast<Map<String , dynamic>>();

    return data.map((json){
      return PengajuanPreview(
        id: json['id'],
        namaPengaju: json['pengaju']['nama'],
        isPemasok: json['pengaju']['is_pemasok'] == 1,
        kodeTransaksi: json['kode_transaksi'],
      );
    }).toList();
  }
}