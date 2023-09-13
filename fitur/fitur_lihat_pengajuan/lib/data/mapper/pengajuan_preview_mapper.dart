import 'dart:convert';

import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';

class PengajuanPreviewMapper {
  List<PengajuanPreview> fromBodyToPengajuanPreview(String body){
    final jsonBody = jsonDecode(body);

    final List<Map<String , dynamic>> data =
      jsonBody['data'].cast<Map<String , dynamic>>();

    return data.map((json){
      final status = StatusPengajuan.from(json['status']);
      final result = PengajuanPreview(
        id: json['id'],
        namaPengaju: json['pengaju']['nama'],
        isPemasok: json['pengaju']['is_pemasok'] == 1,
        kodeTransaksi: json['kode_transaksi'],
        username: json['user']['username'],
        status: status,
      );

      return result;
    }).toList();
  }
}