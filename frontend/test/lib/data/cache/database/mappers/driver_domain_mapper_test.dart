import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/driver_domain_mapper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import '../../../../dummies.dart';

void main() {
  late DriverDomainMapper driverMapper;

  setUp(() {
    driverMapper = DriverDomainMapper();
  });

  test('DriverDomainMapper maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createDriverEntity();

    final Driver result = driverMapper.map(data);

    expect(result, equals(Dummies.createDriver()));
  });
}
