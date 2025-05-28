import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/season_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_domain_mapper.dart';
import 'package:f1_app/domain/models/season/season.dart';
import '../../../../dummies.dart';

void main() {
  late SeasonDomainMapper seasonMapper;
  late DriverDomainMapper driverMapper;

  setUp(() {
    driverMapper = DriverDomainMapper();
    seasonMapper = SeasonDomainMapper(driverMapper);
  });

  test('createSeasonEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createSeasonEntity();

    final Season result = seasonMapper.map(data);

    expect(result, equals(Dummies.createSeason()));
  });
}
