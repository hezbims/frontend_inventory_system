import 'dart:convert';

import 'package:fitur_input_pengajuan/domain/model/barang_preview.dart';
import 'package:flutter/material.dart';

class GetBarangPreviewMapper {
  List<BarangPreview> fromBodyToListBarangPreview(String body){
    final jsonBody = jsonDecode(body);

    final data = jsonBody['data'].cast<Map<String , dynamic>>() as List<Map<String , dynamic>>;
  debugPrint("sukses casting pertama");
    return data.map(
      (json){
        return BarangPreview(
          id: json['id'],
          nama: json['nama'],
          currentStock: json['stock_sekarang'],
        );
      }
    ).toList().cast<BarangPreview>();
  }
}