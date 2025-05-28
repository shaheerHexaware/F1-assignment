import 'package:f1_app/data/cache/database/mappers/race_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/season_domain_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/data/cache/database/database_cache_data_source.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import '../../../dummies.dart';
import 'database_cache_data_source_test.mocks.dart';

@GenerateMocks([
  DatabaseHelper,
  Database,
  Transaction,
  SeasonDomainMapper,
  RaceDomainMapper,
])
void main() {
  late DatabaseCacheDataSource cacheDataSource;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockDatabase mockDatabase;
  late MockTransaction mockTransaction;
  late MockSeasonMapper mockSeasonMapper;
  late MockRaceMapper mockRaceMapper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    mockDatabase = MockDatabase();
    mockTransaction = MockTransaction();
    mockSeasonMapper = MockSeasonMapper();
    mockRaceMapper = MockRaceMapper();
    when(mockDatabaseHelper.database).thenAnswer((_) async => mockDatabase);
    when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
      final Function txnFunction = invocation.positionalArguments.first;
      await txnFunction(mockTransaction);
    });
    cacheDataSource = DatabaseCacheDataSource(
      db: mockDatabaseHelper,
      seasonMapper: mockSeasonMapper,
      raceMapper: mockRaceMapper,
    );
  });

  group('getSeasonsWithChampions', () {
    final dummySeasonMap = Dummies.createSeasonEntity();

    test('returns list of seasons from database', () async {
      when(
        mockDatabase.rawQuery(any, any),
      ).thenAnswer((_) async => [dummySeasonMap]);

      final dummySeason = Dummies.createSeason();
      when(mockSeasonMapper.map(any)).thenReturn(dummySeason);

      final result = await cacheDataSource.getSeasonsWithChampions();

      expect(result, isA<List<Season>>());
      expect(result.length, 1);
      expect(result.first, dummySeason);

      verify(mockDatabase.rawQuery(any, [null, null])).called(1);
    });

    test('returns empty list when no seasons in database', () async {
      when(mockDatabase.rawQuery(any, any)).thenAnswer((_) async => []);

      final result = await cacheDataSource.getSeasonsWithChampions();

      expect(result, isEmpty);
      verify(mockDatabase.rawQuery(any, [null, null])).called(1);
    });

    test(
      'returns filtered seasons when from and to parameters provided',
      () async {
        when(mockDatabase.rawQuery(any, any)).thenAnswer(
          (_) async => [
            dummySeasonMap,
            dummySeasonMap,
            dummySeasonMap,
            dummySeasonMap,
          ],
        );

        final dummySeason = Dummies.createSeason();
        when(mockSeasonMapper.map(any)).thenReturn(dummySeason);

        final result = await cacheDataSource.getSeasonsWithChampions(
          from: 2020,
          to: 2023,
        );

        expect(result, isA<List<Season>>());
        expect(result.length, 4);
        verify(mockDatabase.rawQuery(any, [2020, 2023])).called(1);
      },
    );
  });

  group('getSeasonRaces', () {
    final dummyRaceMap = Dummies.createRaceEntity();

    test('returns list of races from database', () async {
      when(
        mockDatabase.rawQuery(any, any),
      ).thenAnswer((_) async => [dummyRaceMap]);

      final dummyRace = Dummies.createRace();
      when(mockRaceMapper.map(any)).thenReturn(dummyRace);

      final result = await cacheDataSource.getSeasonRaces(Dummies.dummySeason);

      expect(result, isA<List<Race>>());
      expect(result.length, 1);
      expect(result.first, dummyRace);

      expect(
        result.first.constructor.constructorId,
        Dummies.dummyConstructorId,
      );
      expect(result.first.constructor.name, Dummies.dummyConstructorName);
      expect(
        result.first.constructor.nationality,
        Dummies.dummyConstructorNationality,
      );

      verify(mockDatabase.rawQuery(any, [Dummies.dummySeason])).called(1);
    });

    test('returns empty list when no races in database', () async {
      when(mockDatabase.rawQuery(any, any)).thenAnswer((_) async => []);

      final result = await cacheDataSource.getSeasonRaces(Dummies.dummySeason);

      expect(result, isEmpty);
      verify(mockDatabase.rawQuery(any, [Dummies.dummySeason])).called(1);
    });
  });

  group('cacheSeasonsWithChampions', () {
    final dummyDriver = Driver(
      driverId: Dummies.dummyDriverId,
      code: Dummies.dummyDriverCode,
      givenName: Dummies.dummyDriverGivenName,
      familyName: Dummies.dummyDriverFamilyName,
      dateOfBirth: Dummies.dummyDate,
      nationality: Dummies.dummyNationality,
    );

    final dummySeason = Season(
      year: Dummies.dummySeason,
      champion: dummyDriver,
    );

    test('caches seasons and drivers in transaction', () async {
      when(
        mockTransaction.insert(
          any,
          any,
          conflictAlgorithm: anyNamed('conflictAlgorithm'),
        ),
      ).thenAnswer((_) async => 1);

      await cacheDataSource.cacheSeasonsWithChampions([dummySeason]);

      verify(mockDatabase.transaction(any)).called(1);
      verify(
        mockTransaction.insert(
          DatabaseHelper.driversTable,
          any,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
      verify(
        mockTransaction.insert(
          DatabaseHelper.seasonsTable,
          any,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
    });
  });

  group('cacheSeasonRaces', () {
    final dummyDriver = Driver(
      driverId: Dummies.dummyDriverId,
      code: Dummies.dummyDriverCode,
      givenName: Dummies.dummyDriverGivenName,
      familyName: Dummies.dummyDriverFamilyName,
      dateOfBirth: Dummies.dummyDate,
      nationality: Dummies.dummyNationality,
    );

    final dummyCircuit = Circuit(
      circuitId: Dummies.dummyCircuitId,
      circuitName: Dummies.dummyCircuitName,
      locality: Dummies.dummyCircuitLocality,
      country: Dummies.dummyCircuitCountry,
    );

    final dummyConstructor = Constructor(
      constructorId: Dummies.dummyConstructorId,
      name: Dummies.dummyConstructorName,
      nationality: Dummies.dummyConstructorNationality,
    );

    final dummyRace = Race(
      year: Dummies.dummySeason,
      round: Dummies.dummyRound,
      name: Dummies.dummyRaceName,
      date: Dummies.dummyDate,
      winner: dummyDriver,
      circuit: dummyCircuit,
      constructor: dummyConstructor,
    );

    test('caches races with related entities in transaction', () async {
      when(
        mockTransaction.insert(
          any,
          any,
          conflictAlgorithm: anyNamed('conflictAlgorithm'),
        ),
      ).thenAnswer((_) async => 1);
      when(
        mockTransaction.delete(
          any,
          where: anyNamed('where'),
          whereArgs: anyNamed('whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      await cacheDataSource.cacheSeasonRaces(Dummies.dummySeason, [dummyRace]);

      verify(mockDatabase.transaction(any)).called(1);
      verify(
        mockTransaction.insert(
          DatabaseHelper.driversTable,
          any,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
      verify(
        mockTransaction.insert(
          DatabaseHelper.circuitsTable,
          any,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
      verify(
        mockTransaction.insert(
          DatabaseHelper.constructorsTable,
          any,
          conflictAlgorithm: ConflictAlgorithm.replace,
        ),
      ).called(1);
      verify(
        mockTransaction.delete(
          DatabaseHelper.racesTable,
          where: '${DatabaseHelper.columnSeasonYear} = ?',
          whereArgs: [Dummies.dummySeason],
        ),
      ).called(1);
      verify(mockTransaction.insert(DatabaseHelper.racesTable, any)).called(1);
    });
  });

  group('clearCache', () {
    test('clears all tables', () async {
      await cacheDataSource.clearCache();

      verify(mockDatabaseHelper.clearAllTables()).called(1);
    });
  });
}
