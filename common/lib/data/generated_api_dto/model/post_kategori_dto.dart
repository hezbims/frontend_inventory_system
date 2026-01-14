//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostKategoriDto {
  /// Returns a new [PostKategoriDto] instance.
  PostKategoriDto({
    required this.nama,
  });

  String nama;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostKategoriDto &&
    other.nama == nama;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (nama.hashCode);

  @override
  String toString() => 'PostKategoriDto[nama=$nama]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'nama'] = this.nama;
    return json;
  }

  /// Returns a new [PostKategoriDto] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostKategoriDto? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostKategoriDto[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostKategoriDto[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostKategoriDto(
        nama: mapValueOfType<String>(json, r'nama')!,
      );
    }
    return null;
  }

  static List<PostKategoriDto> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostKategoriDto>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostKategoriDto.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostKategoriDto> mapFromJson(dynamic json) {
    final map = <String, PostKategoriDto>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostKategoriDto.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostKategoriDto-objects as value to a dart map
  static Map<String, List<PostKategoriDto>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostKategoriDto>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostKategoriDto.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'nama',
  };
}

