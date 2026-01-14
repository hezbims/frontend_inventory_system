//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SubmitPengajuanBody {
  /// Returns a new [SubmitPengajuanBody] instance.
  SubmitPengajuanBody({
    this.id,
    this.idPengaju,
    this.listBarangAjuan = const [],
    this.statusPengajuan,
  });

  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? idPengaju;

  List<BarangAjuanBody>? listBarangAjuan;

  String? statusPengajuan;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SubmitPengajuanBody &&
    other.id == id &&
    other.idPengaju == idPengaju &&
    _deepEquality.equals(other.listBarangAjuan, listBarangAjuan) &&
    other.statusPengajuan == statusPengajuan;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (idPengaju == null ? 0 : idPengaju!.hashCode) +
    (listBarangAjuan == null ? 0 : listBarangAjuan!.hashCode) +
    (statusPengajuan == null ? 0 : statusPengajuan!.hashCode);

  @override
  String toString() => 'SubmitPengajuanBody[id=$id, idPengaju=$idPengaju, listBarangAjuan=$listBarangAjuan, statusPengajuan=$statusPengajuan]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.idPengaju != null) {
      json[r'id_pengaju'] = this.idPengaju;
    } else {
      json[r'id_pengaju'] = null;
    }
    if (this.listBarangAjuan != null) {
      json[r'list_barang_ajuan'] = this.listBarangAjuan;
    } else {
      json[r'list_barang_ajuan'] = null;
    }
    if (this.statusPengajuan != null) {
      json[r'status_pengajuan'] = this.statusPengajuan;
    } else {
      json[r'status_pengajuan'] = null;
    }
    return json;
  }

  /// Returns a new [SubmitPengajuanBody] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SubmitPengajuanBody? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SubmitPengajuanBody[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SubmitPengajuanBody[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SubmitPengajuanBody(
        id: mapValueOfType<int>(json, r'id'),
        idPengaju: mapValueOfType<int>(json, r'id_pengaju'),
        listBarangAjuan: BarangAjuanBody.listFromJson(json[r'list_barang_ajuan']),
        statusPengajuan: mapValueOfType<String>(json, r'status_pengajuan'),
      );
    }
    return null;
  }

  static List<SubmitPengajuanBody> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SubmitPengajuanBody>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SubmitPengajuanBody.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SubmitPengajuanBody> mapFromJson(dynamic json) {
    final map = <String, SubmitPengajuanBody>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SubmitPengajuanBody.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SubmitPengajuanBody-objects as value to a dart map
  static Map<String, List<SubmitPengajuanBody>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SubmitPengajuanBody>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SubmitPengajuanBody.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

