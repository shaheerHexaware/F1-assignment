import 'remote/remote_data_source.dart';
import '../domain/models/season/season.dart';
import '../domain/models/race/race.dart';

class DataRepository {
  final RemoteDataSource _remoteDataSource;

  DataRepository({RemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? RemoteDataSource();

  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) {
    return _remoteDataSource.getSeasonsWithChampions(from: from, to: to);
  }

  Future<List<Race>> getSeasonRaces(int year) {
    return _remoteDataSource.getSeasonRaces(year);
  }
}
