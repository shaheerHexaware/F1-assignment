import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_database_mapper.dart';
import '../../../../dummies.dart';

void main() {
  late CircuitDatabaseMapper mapper;

  setUp(() {
    mapper = CircuitDatabaseMapper();
  });

  test('maps Circuit model to database map', () {
    final circuit = Dummies.createCircuit();
    final expectedMap = Dummies.createCircuitEntity();

    final result = mapper.map(circuit);

    expect(result, equals(expectedMap));
  });
}
