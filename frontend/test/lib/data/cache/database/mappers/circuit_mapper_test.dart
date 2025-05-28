import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_mapper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import '../../../../dummies.dart';

void main() {
  late CircuitMapper circuitMapper;

  setUp(() {
    circuitMapper = CircuitMapper();
  });

  test('createCircuitEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createCircuitEntity();

    final Circuit result = circuitMapper.map(data);

    expect(result, equals(Dummies.createCircuit()));
  });
}
