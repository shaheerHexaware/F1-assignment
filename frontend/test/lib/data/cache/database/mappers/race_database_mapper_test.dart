import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/race_database_mapper.dart';
import '../../../../dummies.dart';

void main() {
  late RaceDatabaseMapper mapper;

  setUp(() {
    mapper = RaceDatabaseMapper();
  });

  test('maps Race model to database map', () {
    final driver = Dummies.createDriver();
    final circuit = Dummies.createCircuit();
    final constructor = Dummies.createConstructor();
    final race = Dummies.createRace(
      driver: driver,
      circuit: circuit,
      constructor: constructor,
    );

    final result = mapper.map(race);

    expect(result[DatabaseHelper.columnSeasonYear], equals(race.year));
    expect(result[DatabaseHelper.columnRound], equals(race.round));
    expect(result[DatabaseHelper.columnRaceName], equals(race.name));
    expect(result[DatabaseHelper.columnDate], equals(race.date));
    expect(result[DatabaseHelper.columnWinnerId], equals(race.winner.driverId));
    expect(result[DatabaseHelper.columnCircuitId], equals(circuit.circuitId));
    expect(
      result[DatabaseHelper.columnWinningConstructorId],
      equals(race.constructor.constructorId),
    );
  });
}
