import 'package:f1_api_client/api.dart';
import 'package:f1_app/data/remote/mappers/constructor_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummies.dart';

void main() {
  late ConstructorMapper mapper;
  late ConstructorDTO testConstructorDTO;

  setUp(() {
    mapper = ConstructorMapper();
    testConstructorDTO = Dummies.createConstructorDTO();
  });

  test('maps ConstructorDTO to Constructor', () {
    final result = mapper.map(testConstructorDTO);
    final expected = Dummies.createConstructor();

    expect(result.constructorId, equals(expected.constructorId));
    expect(result.name, equals(expected.name));
    expect(result.nationality, equals(expected.nationality));
  });
}
