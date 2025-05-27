import 'remote/remote_data_source.dart';
import 'cache/cache_data_source.dart';
import 'cache/database/database_cache_data_source.dart';
import '../domain/models/season/season.dart';
import '../domain/models/race/race.dart';

class DataRepository {
  final RemoteDataSource _remoteDataSource;
  final CacheDataSource _cacheDataSource;

  DataRepository({
    RemoteDataSource? remoteDataSource,
    CacheDataSource? cacheDataSource,
  }) : _remoteDataSource = remoteDataSource ?? RemoteDataSource(),
       _cacheDataSource = cacheDataSource ?? DatabaseCacheDataSource();

  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) async {
    try {
      final seasons = await _remoteDataSource.getSeasonsWithChampions(
        from: from,
        to: to,
      );

      await _cacheDataSource.cacheSeasonsWithChampions(
        seasons,
        from: from,
        to: to,
      );

      return await _cacheDataSource.getSeasonsWithChampions(from: from, to: to);
    } catch (e) {
      final cachedSeasons = await _cacheDataSource.getSeasonsWithChampions(
        from: from,
        to: to,
      );

      if (cachedSeasons.isNotEmpty) {
        return cachedSeasons;
      }

      rethrow;
    }
  }

  Future<List<Race>> getSeasonRaces(int year) async {
    try {
      final races = await _remoteDataSource.getSeasonRaces(year);

      await _cacheDataSource.cacheSeasonRaces(year, races);

      return await _cacheDataSource.getSeasonRaces(year);
    } catch (e) {
      final cachedRaces = await _cacheDataSource.getSeasonRaces(year);

      if (cachedRaces.isNotEmpty) {
        return cachedRaces;
      }

      rethrow;
    }
  }

  Future<void> clearCache() {
    return _cacheDataSource.clearCache();
  }
}
