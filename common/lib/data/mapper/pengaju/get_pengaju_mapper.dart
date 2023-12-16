import 'dart:convert';

import 'package:common/domain/model/pengaju.dart';

class GetPengajuMapper {
  List<Pengaju> fromBodyToListPengaju(String body){
    final jsonBody = jsonDecode(body);

    final data = jsonBody['data'].cast<Map<String , dynamic>>() as List<Map<String , dynamic>>;

    return data.map(
      (json){
        return Pengaju(
          nama: json['nama'],
          id: json['id'],
          isPemasok: json['is_pemasok'],
        );
      }
    ).toList().cast<Pengaju>();
  }
}