import 'package:f1_api_client/api.dart';
import 'package:f1_app/data/remote/mappers/driver_mapper.dart';
import 'package:f1_app/data/remote/mappers/season_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummies.dart';

void main() {
  late SeasonMapper mapper;
  late SeasonDTO testSeasonDTO;

  setUp(() {
    mapper = SeasonMapper(DriverMapper());
    testSeasonDTO = Dummies.createSeasonDTO();
  });

  test('maps SeasonDTO to Season', () {
    final result = mapper.map(testSeasonDTO);
    final expected = Dummies.createSeason();

    expect(result.year, equals(expected.year));
    expect(result.champion.driverId, equals(expected.champion.driverId));
  });
}
