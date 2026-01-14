//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_helper.dart';


part 'model/barang_ajuan_body.dart';
part 'model/barang_dto.dart';
part 'model/barang_dto_link_info.dart';
part 'model/barang_dto_paginated_result.dart';
part 'model/get_current_user_succeed_response.dart';
part 'model/get_user_dto.dart';
part 'model/kategori_dto.dart';
part 'model/login_failed_response.dart';
part 'model/login_request.dart';
part 'model/login_succeed_response.dart';
part 'model/post_barang_dto.dart';
part 'model/post_kategori_dto.dart';
part 'model/post_new_pengaju_dto.dart';
part 'model/register_request_body.dart';
part 'model/submit_pengajuan_body.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
