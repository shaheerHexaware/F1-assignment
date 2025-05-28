import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/race_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_mapper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import '../../../../dummies.dart';

void main() {
  late RaceMapper raceMapper;
  late DriverMapper driverMapper;
  late CircuitMapper circuitMapper;
  late ConstructorMapper constructorMapper;

  setUp(() {
    driverMapper = DriverMapper();
    circuitMapper = CircuitMapper();
    constructorMapper = ConstructorMapper();
    raceMapper = RaceMapper(driverMapper, circuitMapper, constructorMapper);
  });

  test('createRaceEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createRaceEntity();

    final Race result = raceMapper.map(data);

    expect(result, Dummies.createRace());
  });
}
