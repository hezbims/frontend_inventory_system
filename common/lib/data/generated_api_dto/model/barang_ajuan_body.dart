//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BarangAjuanBody {
  /// Returns a new [BarangAjuanBody] instance.
  BarangAjuanBody({
    this.quantity,
    this.keterangan,
    this.idBarang,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? quantity;

  String? keterangan;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? idBarang;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BarangAjuanBody &&
    other.quantity == quantity &&
    other.keterangan == keterangan &&
    other.idBarang == idBarang;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (quantity == null ? 0 : quantity!.hashCode) +
    (keterangan == null ? 0 : keterangan!.hashCode) +
    (idBarang == null ? 0 : idBarang!.hashCode);

  @override
  String toString() => 'BarangAjuanBody[quantity=$quantity, keterangan=$keterangan, idBarang=$idBarang]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.quantity != null) {
      json[r'quantity'] = this.quantity;
    } else {
      json[r'quantity'] = null;
    }
    if (this.keterangan != null) {
      json[r'keterangan'] = this.keterangan;
    } else {
      json[r'keterangan'] = null;
    }
    if (this.idBarang != null) {
      json[r'id_barang'] = this.idBarang;
    } else {
      json[r'id_barang'] = null;
    }
    return json;
  }

  /// Returns a new [BarangAjuanBody] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BarangAjuanBody? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BarangAjuanBody[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BarangAjuanBody[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BarangAjuanBody(
        quantity: mapValueOfType<int>(json, r'quantity'),
        keterangan: mapValueOfType<String>(json, r'keterangan'),
        idBarang: mapValueOfType<int>(json, r'id_barang'),
      );
    }
    return null;
  }

  static List<BarangAjuanBody> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BarangAjuanBody>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BarangAjuanBody.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BarangAjuanBody> mapFromJson(dynamic json) {
    final map = <String, BarangAjuanBody>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BarangAjuanBody.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BarangAjuanBody-objects as value to a dart map
  static Map<String, List<BarangAjuanBody>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BarangAjuanBody>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BarangAjuanBody.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

