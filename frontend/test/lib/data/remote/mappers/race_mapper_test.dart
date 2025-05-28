import 'package:f1_api_client/api.dart';
import 'package:f1_app/data/remote/mappers/circuit_mapper.dart';
import 'package:f1_app/data/remote/mappers/constructor_mapper.dart';
import 'package:f1_app/data/remote/mappers/driver_mapper.dart';
import 'package:f1_app/data/remote/mappers/race_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummies.dart';

void main() {
  late RaceMapper mapper;
  late RaceDTO testRaceDTO;

  setUp(() {
    mapper = RaceMapper(DriverMapper(), CircuitMapper(), ConstructorMapper());
    testRaceDTO = Dummies.createRaceDTO();
  });

  test('maps RaceDTO to Race', () {
    final result = mapper.map(testRaceDTO);
    final expected = Dummies.createRace();

    expect(result.year, equals(expected.year));
    expect(result.round, equals(expected.round));
    expect(result.name, equals(expected.name));
    expect(result.date, equals(expected.date));
    expect(result.winner.driverId, equals(expected.winner.driverId));
    expect(result.circuit.circuitId, equals(expected.circuit.circuitId));
    expect(
      result.constructor.constructorId,
      equals(expected.constructor.constructorId),
    );
  });
}
