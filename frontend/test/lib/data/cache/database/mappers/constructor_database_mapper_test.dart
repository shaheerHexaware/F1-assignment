import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_database_mapper.dart';
import '../../../../dummies.dart';

void main() {
  late ConstructorDatabaseMapper mapper;

  setUp(() {
    mapper = ConstructorDatabaseMapper();
  });

  test('maps Constructor model to database map', () {
    final constructor = Dummies.createConstructor();
    final expectedMap = Dummies.createConstructorEntity();

    final result = mapper.map(constructor);

    expect(result, equals(expectedMap));
  });
}
