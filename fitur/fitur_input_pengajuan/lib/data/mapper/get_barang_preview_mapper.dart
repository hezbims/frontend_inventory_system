import 'dart:convert';

import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';

class GetBarangPreviewMapper {
  List<BarangPreview> fromBodyToListBarangPreview(String body){
    final jsonBody = jsonDecode(body);

    final data = jsonBody['data'].cast<Map<String , dynamic>>() as List<Map<String , dynamic>>;
    return data.map(
      (json){
        return BarangPreview(
          id: json['id'],
          kodeBarang: json['kode_barang'],
          nama: json['nama'],
          currentStock: json['stock_sekarang'],
        );
      }
    ).toList().cast<BarangPreview>();
  }
}