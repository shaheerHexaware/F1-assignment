import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_domain_mapper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import '../../../../dummies.dart';

void main() {
  late CircuitDomainMapper circuitMapper;

  setUp(() {
    circuitMapper = CircuitDomainMapper();
  });

  test('CircuitDomainMapper maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createCircuitEntity();

    final Circuit result = circuitMapper.map(data);

    expect(result, equals(Dummies.createCircuit()));
  });
}
