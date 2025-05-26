import '../remote/f1_remote_data_source.dart';
import '../../domain/models/season/season.dart';
import '../../domain/models/race/race.dart';

class F1Repository {
  final F1RemoteDataSource _remoteDataSource;

  F1Repository({F1RemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? F1RemoteDataSource();

  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) {
    return _remoteDataSource.getSeasonsWithChampions(from: from, to: to);
  }

  Future<List<Race>> getSeasonRaces(int year) {
    return _remoteDataSource.getSeasonRaces(year);
  }
}
