//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RegisterRequestBody {
  /// Returns a new [RegisterRequestBody] instance.
  RegisterRequestBody({
    this.username,
    this.password,
    required this.isAdmin,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? username;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? password;

  bool isAdmin;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterRequestBody &&
    other.username == username &&
    other.password == password &&
    other.isAdmin == isAdmin;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (username == null ? 0 : username!.hashCode) +
    (password == null ? 0 : password!.hashCode) +
    (isAdmin.hashCode);

  @override
  String toString() => 'RegisterRequestBody[username=$username, password=$password, isAdmin=$isAdmin]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.username != null) {
      json[r'username'] = this.username;
    } else {
      json[r'username'] = null;
    }
    if (this.password != null) {
      json[r'password'] = this.password;
    } else {
      json[r'password'] = null;
    }
      json[r'is_admin'] = this.isAdmin;
    return json;
  }

  /// Returns a new [RegisterRequestBody] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RegisterRequestBody? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RegisterRequestBody[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RegisterRequestBody[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RegisterRequestBody(
        username: mapValueOfType<String>(json, r'username'),
        password: mapValueOfType<String>(json, r'password'),
        isAdmin: mapValueOfType<bool>(json, r'is_admin')!,
      );
    }
    return null;
  }

  static List<RegisterRequestBody> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RegisterRequestBody>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RegisterRequestBody.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RegisterRequestBody> mapFromJson(dynamic json) {
    final map = <String, RegisterRequestBody>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RegisterRequestBody.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RegisterRequestBody-objects as value to a dart map
  static Map<String, List<RegisterRequestBody>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RegisterRequestBody>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RegisterRequestBody.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'is_admin',
  };
}

