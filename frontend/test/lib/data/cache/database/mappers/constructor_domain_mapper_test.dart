import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_domain_mapper.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import '../../../../dummies.dart';

void main() {
  late ConstructorDomainMapper constructorMapper;

  setUp(() {
    constructorMapper = ConstructorDomainMapper();
  });

  test('ConstructorDomainMapper maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createConstructorEntity();

    final Constructor result = constructorMapper.map(data);

    expect(result, equals(Dummies.createConstructor()));
  });
}
