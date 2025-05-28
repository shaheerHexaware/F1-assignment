import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/driver_database_mapper.dart';
import '../../../../dummies.dart';

void main() {
  late DriverDatabaseMapper mapper;

  setUp(() {
    mapper = DriverDatabaseMapper();
  });

  test('maps Driver model to database map', () {
    final driver = Dummies.createDriver();
    final expectedMap = Dummies.createDriverEntity();

    final result = mapper.map(driver);

    expect(result, equals(expectedMap));
  });
}
