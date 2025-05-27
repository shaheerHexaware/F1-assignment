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
import '../../../../dummies.dart' as Dummies;
import 'database_cache_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper, Database, Transaction])
void main() {
  late DatabaseCacheDataSource cacheDataSource;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockDatabase mockDatabase;
  late MockTransaction mockTransaction;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    mockDatabase = MockDatabase();
    mockTransaction = MockTransaction();
    when(mockDatabaseHelper.database).thenAnswer((_) async => mockDatabase);
    when(mockDatabase.transaction(any)).thenAnswer((invocation) async {
      final Function txnFunction = invocation.positionalArguments.first;
      await txnFunction(mockTransaction);
    });
    cacheDataSource = DatabaseCacheDataSource(db: mockDatabaseHelper);
  });

  group('getSeasonsWithChampions', () {
    final dummySeasonMap = {
      DatabaseHelper.columnYear: Dummies.dummySeason,
      DatabaseHelper.columnDriverId: Dummies.dummyDriverId,
      DatabaseHelper.columnDriverCode: Dummies.dummyDriverCode,
      DatabaseHelper.columnGivenName: Dummies.dummyDriverGivenName,
      DatabaseHelper.columnFamilyName: Dummies.dummyDriverFamilyName,
      DatabaseHelper.columnDateOfBirth: Dummies.dummyDate,
      DatabaseHelper.columnNationality: Dummies.dummyNationality,
    };

    test('returns list of seasons from database', () async {
      when(
        mockDatabase.rawQuery(any, any),
      ).thenAnswer((_) async => [dummySeasonMap]);

      final result = await cacheDataSource.getSeasonsWithChampions();

      expect(result, isA<List<Season>>());
      expect(result.length, 1);
      expect(result.first.year, Dummies.dummySeason);
      expect(result.first.champion.driverId, Dummies.dummyDriverId);
      expect(result.first.champion.code, Dummies.dummyDriverCode);
      expect(result.first.champion.givenName, Dummies.dummyDriverGivenName);
      expect(result.first.champion.familyName, Dummies.dummyDriverFamilyName);
      expect(result.first.champion.dateOfBirth, Dummies.dummyDate);
      expect(result.first.champion.nationality, Dummies.dummyNationality);

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
        when(
          mockDatabase.rawQuery(any, any),
        ).thenAnswer((_) async => [dummySeasonMap]);

        final result = await cacheDataSource.getSeasonsWithChampions(
          from: 2020,
          to: 2023,
        );

        expect(result, isA<List<Season>>());
        expect(result.length, 1);
        verify(mockDatabase.rawQuery(any, [2020, 2023])).called(1);
      },
    );
  });

  group('getSeasonRaces', () {
    final dummyRaceMap = {
      DatabaseHelper.columnSeasonYear: Dummies.dummySeason,
      DatabaseHelper.columnRound: Dummies.dummyRound,
      DatabaseHelper.columnRaceName: Dummies.dummyRaceName,
      DatabaseHelper.columnDate: Dummies.dummyDate,
      DatabaseHelper.columnDriverId: Dummies.dummyDriverId,
      DatabaseHelper.columnDriverCode: Dummies.dummyDriverCode,
      DatabaseHelper.columnGivenName: Dummies.dummyDriverGivenName,
      DatabaseHelper.columnFamilyName: Dummies.dummyDriverFamilyName,
      DatabaseHelper.columnDateOfBirth: Dummies.dummyDate,
      DatabaseHelper.columnNationality: Dummies.dummyNationality,
      DatabaseHelper.columnCircuitId: Dummies.dummyCircuitId,
      DatabaseHelper.columnCircuitName: Dummies.dummyCircuitName,
      DatabaseHelper.columnLocality: Dummies.dummyCircuitLocality,
      DatabaseHelper.columnCountry: Dummies.dummyCircuitCountry,
      DatabaseHelper.columnConstructorId: Dummies.dummyConstructorId,
      'constructor_name': Dummies.dummyConstructorName,
      'constructor_nationality': Dummies.dummyConstructorNationality,
    };

    test('returns list of races from database', () async {
      when(
        mockDatabase.rawQuery(any, any),
      ).thenAnswer((_) async => [dummyRaceMap]);

      final result = await cacheDataSource.getSeasonRaces(Dummies.dummySeason);

      expect(result, isA<List<Race>>());
      expect(result.length, 1);
      expect(result.first.year, Dummies.dummySeason);
      expect(result.first.round, Dummies.dummyRound);
      expect(result.first.name, Dummies.dummyRaceName);
      expect(result.first.date, Dummies.dummyDate);

      expect(result.first.winner.driverId, Dummies.dummyDriverId);
      expect(result.first.winner.code, Dummies.dummyDriverCode);
      expect(result.first.winner.givenName, Dummies.dummyDriverGivenName);
      expect(result.first.winner.familyName, Dummies.dummyDriverFamilyName);
      expect(result.first.winner.dateOfBirth, Dummies.dummyDate);
      expect(result.first.winner.nationality, Dummies.dummyNationality);

      expect(result.first.circuit.circuitId, Dummies.dummyCircuitId);
      expect(result.first.circuit.circuitName, Dummies.dummyCircuitName);
      expect(result.first.circuit.locality, Dummies.dummyCircuitLocality);
      expect(result.first.circuit.country, Dummies.dummyCircuitCountry);

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
