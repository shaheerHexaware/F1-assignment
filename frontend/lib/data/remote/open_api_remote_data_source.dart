import 'remote_data_source.dart';
import 'package:f1_api_client/api.dart';
import 'mappers/season_mapper.dart';
import 'mappers/race_mapper.dart';
import 'mappers/driver_mapper.dart';
import 'mappers/circuit_mapper.dart';
import 'mappers/constructor_mapper.dart';
import '../../domain/models/season/season.dart';
import '../../domain/models/race/race.dart';

class OpenApiRemoteDataSource implements RemoteDataSource {
  final F1ControllerApi _api;
  final SeasonMapper _seasonMapper;
  final RaceMapper _raceMapper;

  factory OpenApiRemoteDataSource({
    String baseUrl = 'http://10.0.2.2:8080',
    F1ControllerApi? api,
    SeasonMapper? seasonMapper,
    RaceMapper? raceMapper,
  }) {
    if (api != null && seasonMapper != null && raceMapper != null) {
      return OpenApiRemoteDataSource._(api, seasonMapper, raceMapper);
    }

    final apiClient = ApiClient(basePath: baseUrl);
    final defaultApi = F1ControllerApi(apiClient);
    final driverMapper = DriverMapper();
    final circuitMapper = CircuitMapper();
    final constructorMapper = ConstructorMapper();
    final defaultSeasonMapper = SeasonMapper(driverMapper);
    final defaultRaceMapper = RaceMapper(
      driverMapper,
      circuitMapper,
      constructorMapper,
    );
    return OpenApiRemoteDataSource._(
      defaultApi,
      defaultSeasonMapper,
      defaultRaceMapper,
    );
  }

  OpenApiRemoteDataSource._(this._api, this._seasonMapper, this._raceMapper);

  @override
  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) async {
    try {
      final seasons = await _api.getSeasonsWithChampions(from: from, to: to);
      if (seasons == null) throw Exception('Failed to fetch seasons data');
      return seasons.map(_seasonMapper.map).toList();
    } on ApiException catch (e) {
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<Race>> getSeasonRaces(int year) async {
    try {
      final races = await _api.getSeasonRaces(year);
      if (races == null) throw Exception('Failed to fetch seasons data');
      return races.map(_raceMapper.map).toList();
    } on ApiException catch (e) {
      throw Exception('API Error: ${e.message}');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
