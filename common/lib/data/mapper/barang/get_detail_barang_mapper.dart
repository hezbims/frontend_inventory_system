import 'dart:convert';

import 'package:common/domain/model/barang.dart';

class GetDetailBarangMapper {
  Barang fromBodyToBarang(String body){
    final jsonBody = jsonDecode(body);
    final result = Barang.fromJson(jsonBody['data']);
    return result;
  }
}