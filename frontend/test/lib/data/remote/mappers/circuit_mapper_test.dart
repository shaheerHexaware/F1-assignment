import 'package:f1_api_client/api.dart';
import 'package:f1_app/data/remote/mappers/circuit_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummies.dart';

void main() {
  late CircuitMapper mapper;
  late CircuitDTO testCircuitDTO;

  setUp(() {
    mapper = CircuitMapper();
    testCircuitDTO = Dummies.createCircuitDTO();
  });

  test('maps CircuitDTO to Circuit', () {
    final result = mapper.map(testCircuitDTO);
    final expected = Dummies.createCircuit();

    expect(result.circuitId, equals(expected.circuitId));
    expect(result.circuitName, equals(expected.circuitName));
    expect(result.locality, equals(expected.locality));
    expect(result.country, equals(expected.country));
  });
}
