import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/race_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_domain_mapper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import '../../../../dummies.dart';

void main() {
  late RaceDomainMapper raceMapper;
  late DriverDomainMapper driverMapper;
  late CircuitDomainMapper circuitMapper;
  late ConstructorDomainMapper constructorMapper;

  setUp(() {
    driverMapper = DriverDomainMapper();
    circuitMapper = CircuitDomainMapper();
    constructorMapper = ConstructorDomainMapper();
    raceMapper = RaceDomainMapper(
      driverMapper,
      circuitMapper,
      constructorMapper,
    );
  });

  test('createRaceEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createRaceEntity();

    final Race result = raceMapper.map(data);

    expect(result, Dummies.createRace());
  });
}
