import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/season_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/domain/models/season/season.dart';
import '../../../../dummies.dart';

void main() {
  late SeasonMapper seasonMapper;
  late DriverMapper driverMapper;

  setUp(() {
    driverMapper = DriverMapper();
    seasonMapper = SeasonMapper(driverMapper);
  });

  test('createSeasonEntity maps data correctly', () {
    final Map<String, dynamic> data = Dummies.createSeasonEntity();

    final Season result = seasonMapper.map(data);

    expect(result, equals(Dummies.createSeason()));
  });
}
