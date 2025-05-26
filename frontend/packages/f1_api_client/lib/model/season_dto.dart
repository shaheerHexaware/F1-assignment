//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SeasonDTO {
  /// Returns a new [SeasonDTO] instance.
  SeasonDTO({
    required this.year,
    required this.champion,
  });

  int year;

  DriverDTO champion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SeasonDTO &&
    other.year == year &&
    other.champion == champion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (year.hashCode) +
    (champion.hashCode);

  @override
  String toString() => 'SeasonDTO[year=$year, champion=$champion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'year'] = this.year;
      json[r'champion'] = this.champion;
    return json;
  }

  /// Returns a new [SeasonDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SeasonDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SeasonDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SeasonDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SeasonDTO(
        year: mapValueOfType<int>(json, r'year')!,
        champion: DriverDTO.fromJson(json[r'champion'])!,
      );
    }
    return null;
  }

  static List<SeasonDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SeasonDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SeasonDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SeasonDTO> mapFromJson(dynamic json) {
    final map = <String, SeasonDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SeasonDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SeasonDTO-objects as value to a dart map
  static Map<String, List<SeasonDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SeasonDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SeasonDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'year',
    'champion',
  };
}

