import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import '../../../../dummies.dart';

void main() {
  late DriverMapper driverMapper;

  setUp(() {
    driverMapper = DriverMapper();
  });

  test('createDriverEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createDriverEntity();

    final Driver result = driverMapper.map(data);

    expect(result, equals(Dummies.createDriver()));
  });
}
