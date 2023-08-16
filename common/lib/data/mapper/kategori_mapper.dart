import 'dart:convert';

import 'package:common/domain/model/kategori.dart';

abstract class KategoriMapper {
  static List<Kategori> getListKategoriFromBody(String jsonString){
    final json = jsonDecode(jsonString);
    final List<Map<String , dynamic>> data = json['data'].cast<Map<String , dynamic>>();

    return data.map((e) => Kategori.fromJson(e)).toList();
  }

}