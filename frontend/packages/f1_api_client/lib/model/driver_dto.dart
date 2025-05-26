//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DriverDTO {
  /// Returns a new [DriverDTO] instance.
  DriverDTO({
    required this.driverId,
    this.code,
    required this.givenName,
    required this.familyName,
    required this.dateOfBirth,
    required this.nationality,
  });

  String driverId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? code;

  String givenName;

  String familyName;

  String dateOfBirth;

  String nationality;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverDTO &&
    other.driverId == driverId &&
    other.code == code &&
    other.givenName == givenName &&
    other.familyName == familyName &&
    other.dateOfBirth == dateOfBirth &&
    other.nationality == nationality;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (driverId.hashCode) +
    (code == null ? 0 : code!.hashCode) +
    (givenName.hashCode) +
    (familyName.hashCode) +
    (dateOfBirth.hashCode) +
    (nationality.hashCode);

  @override
  String toString() => 'DriverDTO[driverId=$driverId, code=$code, givenName=$givenName, familyName=$familyName, dateOfBirth=$dateOfBirth, nationality=$nationality]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'driverId'] = this.driverId;
    if (this.code != null) {
      json[r'code'] = this.code;
    } else {
      json[r'code'] = null;
    }
      json[r'givenName'] = this.givenName;
      json[r'familyName'] = this.familyName;
      json[r'dateOfBirth'] = this.dateOfBirth;
      json[r'nationality'] = this.nationality;
    return json;
  }

  /// Returns a new [DriverDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DriverDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DriverDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DriverDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DriverDTO(
        driverId: mapValueOfType<String>(json, r'driverId')!,
        code: mapValueOfType<String>(json, r'code'),
        givenName: mapValueOfType<String>(json, r'givenName')!,
        familyName: mapValueOfType<String>(json, r'familyName')!,
        dateOfBirth: mapValueOfType<String>(json, r'dateOfBirth')!,
        nationality: mapValueOfType<String>(json, r'nationality')!,
      );
    }
    return null;
  }

  static List<DriverDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DriverDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DriverDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DriverDTO> mapFromJson(dynamic json) {
    final map = <String, DriverDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DriverDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DriverDTO-objects as value to a dart map
  static Map<String, List<DriverDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DriverDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DriverDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'driverId',
    'givenName',
    'familyName',
    'dateOfBirth',
    'nationality',
  };
}

