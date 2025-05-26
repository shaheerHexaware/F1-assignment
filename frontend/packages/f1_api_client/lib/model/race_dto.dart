//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RaceDTO {
  /// Returns a new [RaceDTO] instance.
  RaceDTO({
    required this.seasonYear,
    required this.round,
    required this.raceName,
    required this.circuit,
    required this.date,
    required this.winningDriver,
    required this.winningConstructor,
  });

  int seasonYear;

  int round;

  String raceName;

  CircuitDTO circuit;

  String date;

  DriverDTO winningDriver;

  ConstructorDTO winningConstructor;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RaceDTO &&
    other.seasonYear == seasonYear &&
    other.round == round &&
    other.raceName == raceName &&
    other.circuit == circuit &&
    other.date == date &&
    other.winningDriver == winningDriver &&
    other.winningConstructor == winningConstructor;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (seasonYear.hashCode) +
    (round.hashCode) +
    (raceName.hashCode) +
    (circuit.hashCode) +
    (date.hashCode) +
    (winningDriver.hashCode) +
    (winningConstructor.hashCode);

  @override
  String toString() => 'RaceDTO[seasonYear=$seasonYear, round=$round, raceName=$raceName, circuit=$circuit, date=$date, winningDriver=$winningDriver, winningConstructor=$winningConstructor]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'seasonYear'] = this.seasonYear;
      json[r'round'] = this.round;
      json[r'raceName'] = this.raceName;
      json[r'circuit'] = this.circuit;
      json[r'date'] = this.date;
      json[r'winningDriver'] = this.winningDriver;
      json[r'winningConstructor'] = this.winningConstructor;
    return json;
  }

  /// Returns a new [RaceDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RaceDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RaceDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RaceDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RaceDTO(
        seasonYear: mapValueOfType<int>(json, r'seasonYear')!,
        round: mapValueOfType<int>(json, r'round')!,
        raceName: mapValueOfType<String>(json, r'raceName')!,
        circuit: CircuitDTO.fromJson(json[r'circuit'])!,
        date: mapValueOfType<String>(json, r'date')!,
        winningDriver: DriverDTO.fromJson(json[r'winningDriver'])!,
        winningConstructor: ConstructorDTO.fromJson(json[r'winningConstructor'])!,
      );
    }
    return null;
  }

  static List<RaceDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RaceDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RaceDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RaceDTO> mapFromJson(dynamic json) {
    final map = <String, RaceDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RaceDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RaceDTO-objects as value to a dart map
  static Map<String, List<RaceDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RaceDTO>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RaceDTO.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'seasonYear',
    'round',
    'raceName',
    'circuit',
    'date',
    'winningDriver',
    'winningConstructor',
  };
}

