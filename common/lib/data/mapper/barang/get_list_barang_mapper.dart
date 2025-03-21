import 'dart:convert';

import 'package:common/data/mapper/pagination/pagination_mapper.dart';
import 'package:common/domain/model/barang.dart';
import 'package:common/domain/model/page_result.dart';
import 'package:dependencies/http.dart';

abstract class GetListBarangMapper {
  static List<Barang> getListBarangFromBody(String body){
    final jsonBody = jsonDecode(body);
    final List<Map<String , dynamic>> jsonList = jsonBody['data'].cast<Map<String , dynamic>>();
    final data = jsonList.map(
      (jsonBarang){
        return Barang.fromJson(jsonBarang);
      }
    ).toList();
    return data;
  }
  
  static PageResult<Barang> getPageBarangFromBody(Response response){
    String body = response.body;
    final jsonBody = jsonDecode(body);
    final List<Map<String , dynamic>> jsonList = jsonBody['data'].cast<Map<String , dynamic>>();
    final data = jsonList.map(
            (jsonBarang){
          return Barang.fromJson(jsonBarang);
        }
    ).toList();
    return PageResult(
      listData: data,
      links: PaginationMapper.getPageLinks(jsonBody)
    );
  }
}