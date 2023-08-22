import 'dart:convert';

import 'package:fitur_input_pengajuan/data/field/pengaju_field.dart';
import 'package:fitur_input_pengajuan/domain/model/pengaju.dart';

class CreatePengajuMapper {
  String fromPengajuToBody(Pengaju pengaju){
    final jsonMap = {
      PengajuField.isPemasok : pengaju.isPemasok,
      PengajuField.nama : pengaju.nama,
    };

    return jsonEncode(jsonMap);
  }
}