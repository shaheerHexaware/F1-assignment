import 'package:f1_api_client/api.dart';
import 'package:f1_app/data/remote/mappers/driver_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummies.dart';

void main() {
  late DriverMapper mapper;
  late DriverDTO testDriverDTO;

  setUp(() {
    mapper = DriverMapper();
  });

  test('maps DriverDTO to Driver', () {
    testDriverDTO = Dummies.createDriverDTO();
    final result = mapper.map(testDriverDTO);
    final expected = Dummies.createDriver();

    expect(result.driverId, equals(expected.driverId));
    expect(result.code, equals(expected.code));
    expect(result.givenName, equals(expected.givenName));
    expect(result.familyName, equals(expected.familyName));
    expect(result.dateOfBirth, equals(expected.dateOfBirth));
    expect(result.nationality, equals(expected.nationality));
  });

  test('maps DriverDTO to Driver when code is null', () {
    testDriverDTO = Dummies.createDriverDTO(code: null);
    final result = mapper.map(testDriverDTO);
    final expected = Dummies.createDriver(code: null);

    expect(result.driverId, equals(expected.driverId));
    expect(result.code, equals(expected.code));
    expect(result.givenName, equals(expected.givenName));
    expect(result.familyName, equals(expected.familyName));
    expect(result.dateOfBirth, equals(expected.dateOfBirth));
    expect(result.nationality, equals(expected.nationality));
  });
}
