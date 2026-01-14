//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KategoriDto {
  /// Returns a new [KategoriDto] instance.
  KategoriDto({
    this.id,
    this.nama,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? nama;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KategoriDto &&
    other.id == id &&
    other.nama == nama;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (nama == null ? 0 : nama!.hashCode);

  @override
  String toString() => 'KategoriDto[id=$id, nama=$nama]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.nama != null) {
      json[r'nama'] = this.nama;
    } else {
      json[r'nama'] = null;
    }
    return json;
  }

  /// Returns a new [KategoriDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KategoriDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KategoriDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KategoriDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KategoriDto(
        id: mapValueOfType<int>(json, r'id'),
        nama: mapValueOfType<String>(json, r'nama'),
      );
    }
    return null;
  }

  static List<KategoriDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KategoriDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KategoriDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KategoriDto> mapFromJson(dynamic json) {
    final map = <String, KategoriDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KategoriDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KategoriDto-objects as value to a dart map
  static Map<String, List<KategoriDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KategoriDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KategoriDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

