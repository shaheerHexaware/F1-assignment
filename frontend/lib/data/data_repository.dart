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
      // Always try to fetch from remote first
      final seasons = await _remoteDataSource.getSeasonsWithChampions(
        from: from,
        to: to,
      );

      // Store in database
      await _cacheDataSource.cacheSeasonsWithChampions(
        seasons,
        from: from,
        to: to,
      );

      // Return from database to ensure consistency
      return await _cacheDataSource.getSeasonsWithChampions(from: from, to: to);
    } catch (e) {
      // On API error, try to get from cache
      final cachedSeasons = await _cacheDataSource.getSeasonsWithChampions(
        from: from,
        to: to,
      );

      if (cachedSeasons.isNotEmpty) {
        return cachedSeasons;
      }

      // If no cached data, rethrow the error
      rethrow;
    }
  }

  Future<List<Race>> getSeasonRaces(int year) async {
    try {
      // Always try to fetch from remote first
      final races = await _remoteDataSource.getSeasonRaces(year);

      // Store in database
      await _cacheDataSource.cacheSeasonRaces(year, races);

      // Return from database to ensure consistency
      return await _cacheDataSource.getSeasonRaces(year);
    } catch (e) {
      // On API error, try to get from cache
      final cachedRaces = await _cacheDataSource.getSeasonRaces(year);

      if (cachedRaces.isNotEmpty) {
        return cachedRaces;
      }

      // If no cached data, rethrow the error
      rethrow;
    }
  }

  Future<void> clearCache() {
    return _cacheDataSource.clearCache();
  }
}
