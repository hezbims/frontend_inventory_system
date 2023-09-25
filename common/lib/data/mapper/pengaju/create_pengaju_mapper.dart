import 'dart:convert';

import 'package:common/constant/json_field/pengaju_field.dart';
import 'package:common/domain/model/pengaju.dart';

class CreatePengajuMapper {
  String fromPengajuToBody(Pengaju pengaju){
    final jsonMap = {
      PengajuField.isPemasok : pengaju.isPemasok,
      PengajuField.nama : pengaju.nama,
    };

    return jsonEncode(jsonMap);
  }
}