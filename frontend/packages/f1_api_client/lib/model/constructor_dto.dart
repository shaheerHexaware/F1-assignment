//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConstructorDTO {
  /// Returns a new [ConstructorDTO] instance.
  ConstructorDTO({
    required this.constructorId,
    required this.name,
    required this.nationality,
  });

  String constructorId;

  String name;

  String nationality;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConstructorDTO &&
    other.constructorId == constructorId &&
    other.name == name &&
    other.nationality == nationality;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (constructorId.hashCode) +
    (name.hashCode) +
    (nationality.hashCode);

  @override
  String toString() => 'ConstructorDTO[constructorId=$constructorId, name=$name, nationality=$nationality]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'constructorId'] = this.constructorId;
      json[r'name'] = this.name;
      json[r'nationality'] = this.nationality;
    return json;
  }

  /// Returns a new [ConstructorDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConstructorDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConstructorDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConstructorDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConstructorDTO(
        constructorId: mapValueOfType<String>(json, r'constructorId')!,
        name: mapValueOfType<String>(json, r'name')!,
        nationality: mapValueOfType<String>(json, r'nationality')!,
      );
    }
    return null;
  }

  static List<ConstructorDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConstructorDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConstructorDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConstructorDTO> mapFromJson(dynamic json) {
    final map = <String, ConstructorDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConstructorDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConstructorDTO-objects as value to a dart map
  static Map<String, List<ConstructorDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConstructorDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConstructorDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'constructorId',
    'name',
    'nationality',
  };
}

