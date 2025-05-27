import '../../domain/models/season/season.dart';
import '../../domain/models/race/race.dart';

abstract class CacheDataSource {
  Future<List<Season>> getSeasonsWithChampions({int? from, int? to});
  Future<List<Race>> getSeasonRaces(int year);

  Future<void> cacheSeasonsWithChampions(
    List<Season> seasons, {
    int? from,
    int? to,
  });
  Future<void> cacheSeasonRaces(int year, List<Race> races);

  Future<void> clearCache();
}
