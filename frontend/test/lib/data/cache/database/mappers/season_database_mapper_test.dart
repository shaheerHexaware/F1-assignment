import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:f1_app/data/cache/database/mappers/season_database_mapper.dart';
import '../../../../dummies.dart';

void main() {
  late SeasonDatabaseMapper mapper;

  setUp(() {
    mapper = SeasonDatabaseMapper();
  });

  test('maps Season model to database map', () {
    final driver = Dummies.createDriver();
    final season = Dummies.createSeason(champion: driver);

    final result = mapper.map(season);

    expect(result[DatabaseHelper.columnYear], equals(season.year));
    expect(result[DatabaseHelper.columnChampionId], equals(driver.driverId));
  });
}
