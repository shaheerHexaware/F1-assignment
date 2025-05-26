import 'package:f1_api_client/api.dart';
import '../../domain/models/season/season.dart';
import '../../domain/models/race/race.dart';
import 'mappers/season_mapper.dart';
import 'mappers/race_mapper.dart';
import 'mappers/driver_mapper.dart';
import 'mappers/circuit_mapper.dart';
import 'mappers/constructor_mapper.dart';

/// A remote data source for fetching F1 data from the API
class F1RemoteDataSource {
  final F1ControllerApi _api;
  final SeasonMapper _seasonMapper;
  final RaceMapper _raceMapper;

  /// Creates a new [F1RemoteDataSource] instance
  ///
  /// The [baseUrl] parameter specifies the base URL of the API server
  factory F1RemoteDataSource({String baseUrl = 'http://localhost:8080'}) {
    final apiClient = ApiClient(basePath: baseUrl);
    final api = F1ControllerApi(apiClient);
    final driverMapper = DriverMapper();
    final circuitMapper = CircuitMapper();
    final constructorMapper = ConstructorMapper();
    final seasonMapper = SeasonMapper(driverMapper);
    final raceMapper = RaceMapper(
      driverMapper,
      circuitMapper,
      constructorMapper,
    );
    return F1RemoteDataSource._(api, seasonMapper, raceMapper);
  }

  F1RemoteDataSource._(this._api, this._seasonMapper, this._raceMapper);

  /// Fetches seasons with their respective champions
  ///
  /// [from] Optional parameter to specify the start year (default: 2005)
  /// [to] Optional parameter to specify the end year
  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) async {
    try {
      final seasons = await _api.getSeasonsWithChampions(from: from, to: to);
      if (seasons == null) throw _handleError(null);
      // Convert API response to domain models using SeasonMapper
      return seasons.map(_seasonMapper.map).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Fetches races for a specific season
  ///
  /// [year] The year of the season to fetch races for
  Future<List<Race>> getSeasonRaces(int year) async {
    try {
      final races = await _api.getSeasonRaces(year);
      if (races == null) throw _handleError(null);
      // Convert API response to domain models using RaceMapper
      return races.map(_raceMapper.map).toList();
    } catch (e) {
      throw _handleError(e);
    }
  }

  /// Handles API errors and converts them to more meaningful exceptions
  Exception _handleError(dynamic error) {
    if (error == null) {
      return Exception('Failed to fetch seasons data');
    }
    if (error is ApiException) {
      return Exception('API Error: ${error.message}');
    }
    return Exception('An unexpected error occurred: $error');
  }
}
