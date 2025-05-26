//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CircuitDTO {
  /// Returns a new [CircuitDTO] instance.
  CircuitDTO({
    required this.circuitId,
    required this.circuitName,
    required this.location,
  });

  String circuitId;

  String circuitName;

  CircuitLocationDTO location;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CircuitDTO &&
    other.circuitId == circuitId &&
    other.circuitName == circuitName &&
    other.location == location;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (circuitId.hashCode) +
    (circuitName.hashCode) +
    (location.hashCode);

  @override
  String toString() => 'CircuitDTO[circuitId=$circuitId, circuitName=$circuitName, location=$location]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'circuitId'] = this.circuitId;
      json[r'circuitName'] = this.circuitName;
      json[r'Location'] = this.location;
    return json;
  }

  /// Returns a new [CircuitDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CircuitDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CircuitDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CircuitDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CircuitDTO(
        circuitId: mapValueOfType<String>(json, r'circuitId')!,
        circuitName: mapValueOfType<String>(json, r'circuitName')!,
        location: CircuitLocationDTO.fromJson(json[r'Location'])!,
      );
    }
    return null;
  }

  static List<CircuitDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CircuitDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CircuitDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CircuitDTO> mapFromJson(dynamic json) {
    final map = <String, CircuitDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CircuitDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CircuitDTO-objects as value to a dart map
  static Map<String, List<CircuitDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CircuitDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CircuitDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'circuitId',
    'circuitName',
    'Location',
  };
}

