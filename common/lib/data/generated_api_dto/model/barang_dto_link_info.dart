//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BarangDtoLinkInfo {
  /// Returns a new [BarangDtoLinkInfo] instance.
  BarangDtoLinkInfo({
    this.next,
    this.currentPage,
    this.nextPage,
    this.prevPage,
    this.totalPage,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? next;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? currentPage;

  int? nextPage;

  int? prevPage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? totalPage;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BarangDtoLinkInfo &&
    other.next == next &&
    other.currentPage == currentPage &&
    other.nextPage == nextPage &&
    other.prevPage == prevPage &&
    other.totalPage == totalPage;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (next == null ? 0 : next!.hashCode) +
    (currentPage == null ? 0 : currentPage!.hashCode) +
    (nextPage == null ? 0 : nextPage!.hashCode) +
    (prevPage == null ? 0 : prevPage!.hashCode) +
    (totalPage == null ? 0 : totalPage!.hashCode);

  @override
  String toString() => 'BarangDtoLinkInfo[next=$next, currentPage=$currentPage, nextPage=$nextPage, prevPage=$prevPage, totalPage=$totalPage]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.next != null) {
      json[r'next'] = this.next;
    } else {
      json[r'next'] = null;
    }
    if (this.currentPage != null) {
      json[r'current_page'] = this.currentPage;
    } else {
      json[r'current_page'] = null;
    }
    if (this.nextPage != null) {
      json[r'next_page'] = this.nextPage;
    } else {
      json[r'next_page'] = null;
    }
    if (this.prevPage != null) {
      json[r'prev_page'] = this.prevPage;
    } else {
      json[r'prev_page'] = null;
    }
    if (this.totalPage != null) {
      json[r'total_page'] = this.totalPage;
    } else {
      json[r'total_page'] = null;
    }
    return json;
  }

  /// Returns a new [BarangDtoLinkInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BarangDtoLinkInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BarangDtoLinkInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BarangDtoLinkInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BarangDtoLinkInfo(
        next: mapValueOfType<bool>(json, r'next'),
        currentPage: mapValueOfType<int>(json, r'current_page'),
        nextPage: mapValueOfType<int>(json, r'next_page'),
        prevPage: mapValueOfType<int>(json, r'prev_page'),
        totalPage: mapValueOfType<int>(json, r'total_page'),
      );
    }
    return null;
  }

  static List<BarangDtoLinkInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BarangDtoLinkInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BarangDtoLinkInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BarangDtoLinkInfo> mapFromJson(dynamic json) {
    final map = <String, BarangDtoLinkInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BarangDtoLinkInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BarangDtoLinkInfo-objects as value to a dart map
  static Map<String, List<BarangDtoLinkInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BarangDtoLinkInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BarangDtoLinkInfo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

