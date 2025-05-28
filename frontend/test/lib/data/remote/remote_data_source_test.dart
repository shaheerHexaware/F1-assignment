import 'package:f1_app/data/remote/open_api_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:f1_api_client/api.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/data/remote/remote_data_source.dart';
import 'package:f1_app/data/remote/mappers/season_mapper.dart';
import 'package:f1_app/data/remote/mappers/race_mapper.dart';
import 'package:f1_app/data/remote/mappers/driver_mapper.dart';
import 'package:f1_app/data/remote/mappers/circuit_mapper.dart';
import 'package:f1_app/data/remote/mappers/constructor_mapper.dart';
import '../../dummies.dart';
import 'remote_data_source_test.mocks.dart';

@GenerateMocks([F1ControllerApi])
void main() {
  late RemoteDataSource remoteDataSource;
  late MockF1ControllerApi mockApi;
  late SeasonMapper seasonMapper;
  late RaceMapper raceMapper;

  setUp(() {
    mockApi = MockF1ControllerApi();
    final driverMapper = DriverMapper();
    final circuitMapper = CircuitMapper();
    final constructorMapper = ConstructorMapper();
    seasonMapper = SeasonMapper(driverMapper);
    raceMapper = RaceMapper(driverMapper, circuitMapper, constructorMapper);
    remoteDataSource = OpenApiRemoteDataSource(
      api: mockApi,
      seasonMapper: seasonMapper,
      raceMapper: raceMapper,
    );
  });

  group('getSeasonsWithChampions', () {
    test('returns list of seasons when API call is successful', () async {
      DriverDTO driverDTO = DriverDTO(
        driverId: Dummies.dummyDriverId,
        code: Dummies.dummyDriverCode,
        givenName: Dummies.dummyDriverGivenName,
        familyName: Dummies.dummyDriverFamilyName,
        dateOfBirth: Dummies.dummyDate,
        nationality: Dummies.dummyNationality,
      );
      SeasonDTO seasonDTO = SeasonDTO(
        year: Dummies.dummySeason,
        champion: driverDTO,
      );
      final apiSeasons = [seasonDTO];
      when(
        mockApi.getSeasonsWithChampions(from: null, to: null),
      ).thenAnswer((_) async => apiSeasons);

      final result = await remoteDataSource.getSeasonsWithChampions();

      expect(result, isA<List<Season>>());
      expect(result.length, 1);
      expect(result.first.year, Dummies.dummySeason);
      expect(result.first.year, seasonDTO.year);
      expect(result.first.champion.driverId, seasonDTO.champion.driverId);
      expect(result.first.champion.code, seasonDTO.champion.code);
      expect(result.first.champion.givenName, seasonDTO.champion.givenName);
      expect(result.first.champion.familyName, seasonDTO.champion.familyName);
      expect(result.first.champion.dateOfBirth, seasonDTO.champion.dateOfBirth);
      expect(result.first.champion.nationality, seasonDTO.champion.nationality);
      verify(mockApi.getSeasonsWithChampions(from: null, to: null)).called(1);
    });

    test('throws exception when API returns null', () async {
      when(
        mockApi.getSeasonsWithChampions(from: null, to: null),
      ).thenAnswer((_) async => null);

      expect(
        () => remoteDataSource.getSeasonsWithChampions(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            'Exception: Failed to fetch seasons data',
          ),
        ),
      );
    });

    test('throws exception when API call fails', () async {
      when(
        mockApi.getSeasonsWithChampions(from: null, to: null),
      ).thenThrow(ApiException(400, 'Bad Request'));

      expect(
        () => remoteDataSource.getSeasonsWithChampions(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            'Exception: API Error: Bad Request',
          ),
        ),
      );
    });
  });

  group('getSeasonRaces', () {
    test('returns list of races when API call is successful', () async {
      ConstructorDTO constructorDTO = ConstructorDTO(
        constructorId: Dummies.dummyConstructorId,
        name: Dummies.dummyConstructorName,
        nationality: Dummies.dummyConstructorNationality,
      );

      DriverDTO driverDTO = DriverDTO(
        driverId: Dummies.dummyDriverId,
        code: Dummies.dummyDriverCode,
        givenName: Dummies.dummyDriverGivenName,
        familyName: Dummies.dummyDriverFamilyName,
        dateOfBirth: Dummies.dummyDate,
        nationality: Dummies.dummyNationality,
      );

      CircuitDTO circuitDTO = CircuitDTO(
        circuitId: Dummies.dummyCircuitId,
        circuitName: Dummies.dummyCircuitName,
        location: CircuitLocationDTO(
          locality: Dummies.dummyCircuitLocality,
          country: Dummies.dummyCircuitCountry,
        ),
      );

      RaceDTO raceDTO = RaceDTO(
        seasonYear: Dummies.dummySeason,
        round: Dummies.dummyRound,
        raceName: Dummies.dummyRaceName,
        date: Dummies.dummyDate,
        circuit: circuitDTO,
        winningDriver: driverDTO,
        winningConstructor: constructorDTO,
      );

      final apiRaces = [raceDTO];
      when(
        mockApi.getSeasonRaces(Dummies.dummySeason),
      ).thenAnswer((_) async => apiRaces);

      final result = await remoteDataSource.getSeasonRaces(Dummies.dummySeason);

      expect(result, isA<List<Race>>());
      expect(result.length, 1);
      expect(result.first.name, raceDTO.raceName);
      expect(result.first.year, raceDTO.seasonYear);
      expect(result.first.round, raceDTO.round);
      expect(result.first.date, raceDTO.date);

      expect(result.first.circuit.circuitId, raceDTO.circuit.circuitId);
      expect(result.first.circuit.circuitName, raceDTO.circuit.circuitName);

      expect(result.first.winner.driverId, raceDTO.winningDriver.driverId);
      expect(result.first.winner.code, raceDTO.winningDriver.code);
      expect(result.first.winner.givenName, raceDTO.winningDriver.givenName);
      expect(result.first.winner.familyName, raceDTO.winningDriver.familyName);
      expect(
        result.first.winner.dateOfBirth,
        raceDTO.winningDriver.dateOfBirth,
      );
      expect(
        result.first.winner.nationality,
        raceDTO.winningDriver.nationality,
      );

      expect(
        result.first.constructor.constructorId,
        raceDTO.winningConstructor.constructorId,
      );
      expect(result.first.constructor.name, raceDTO.winningConstructor.name);
      expect(
        result.first.constructor.nationality,
        raceDTO.winningConstructor.nationality,
      );

      verify(mockApi.getSeasonRaces(Dummies.dummySeason)).called(1);
    });

    test('throws exception when API returns null', () async {
      when(
        mockApi.getSeasonRaces(Dummies.dummySeason),
      ).thenAnswer((_) async => null);

      expect(
        () => remoteDataSource.getSeasonRaces(Dummies.dummySeason),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            'Exception: Failed to fetch seasons data',
          ),
        ),
      );
    });

    test('throws exception when API call fails', () async {
      when(
        mockApi.getSeasonRaces(Dummies.dummySeason),
      ).thenThrow(ApiException(400, 'Bad Request'));

      expect(
        () => remoteDataSource.getSeasonRaces(Dummies.dummySeason),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            'Exception: API Error: Bad Request',
          ),
        ),
      );
    });
  });
}
