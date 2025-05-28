import '../../domain/models/season/season.dart';
import '../../domain/models/race/race.dart';

abstract class RemoteDataSource {
  Future<List<Season>> getSeasonsWithChampions({int? from, int? to});
  Future<List<Race>> getSeasonRaces(int year);
}
