import 'dart:convert';

import 'package:common/domain/model/barang.dart';

abstract class BarangMapper {
  static List<Barang> getListBarangFromBody(String body){
    final jsonBody = jsonDecode(body);
    final List<Map<String , dynamic>> jsonList = jsonBody['data'].cast<Map<String , dynamic>>();

    return jsonList.map(
      (jsonBarang) => Barang.fromJson(jsonBarang)
    ).toList();
  }
}