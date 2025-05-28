import 'package:f1_app/data/cache/cache_data_source.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/race_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/season_mapper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCacheDataSource implements CacheDataSource {
  final DatabaseHelper _db;
  final SeasonMapper _seasonMapper;
  final RaceMapper _raceMapper;

  factory DatabaseCacheDataSource({
    DatabaseHelper? db,
    SeasonMapper? seasonMapper,
    RaceMapper? raceMapper,
  }) {
    if (db != null && seasonMapper != null && raceMapper != null) {
      return DatabaseCacheDataSource._(db, seasonMapper, raceMapper);
    }

    final defaultDb = DatabaseHelper.instance;
    final driverMapper = DriverMapper();
    final circuitMapper = CircuitMapper();
    final constructorMapper = ConstructorMapper();
    final defaultSeasonMapper = SeasonMapper(driverMapper);
    final defaultRaceMapper = RaceMapper(
      driverMapper,
      circuitMapper,
      constructorMapper,
    );
    return DatabaseCacheDataSource._(
      defaultDb,
      defaultSeasonMapper,
      defaultRaceMapper,
    );
  }

  DatabaseCacheDataSource._(this._db, this._seasonMapper, this._raceMapper);

  @override
  Future<List<Season>> getSeasonsWithChampions({int? from, int? to}) async {
    final database = await _db.database;
    final List<Map<String, dynamic>> seasonMaps = await database.rawQuery(
      '''
      SELECT s.*, 
             d.${DatabaseHelper.columnDriverId}, d.${DatabaseHelper.columnDriverCode}, 
             d.${DatabaseHelper.columnDriverGivenName}, d.${DatabaseHelper.columnDriverFamilyName}, 
             d.${DatabaseHelper.columnDriverDateOfBirth}, d.${DatabaseHelper.columnDriverNationality}
      FROM ${DatabaseHelper.seasonsTable} s
      INNER JOIN ${DatabaseHelper.driversTable} d 
        ON s.${DatabaseHelper.columnChampionId} = d.${DatabaseHelper.columnDriverId}
      WHERE (\$1 IS NULL OR s.${DatabaseHelper.columnYear} >= \$1)
        AND (\$2 IS NULL OR s.${DatabaseHelper.columnYear} <= \$2)
      ORDER BY s.${DatabaseHelper.columnYear} DESC
    ''',
      [from, to],
    );

    return seasonMaps.map((map) {
      return _seasonMapper.map(map);
    }).toList();
  }

  @override
  Future<List<Race>> getSeasonRaces(int year) async {
    final database = await _db.database;
    final List<Map<String, dynamic>> raceMaps = await database.rawQuery(
      '''
      SELECT r.*,
             d.${DatabaseHelper.columnDriverId}, d.${DatabaseHelper.columnDriverCode}, 
             d.${DatabaseHelper.columnDriverGivenName}, d.${DatabaseHelper.columnDriverFamilyName}, 
             d.${DatabaseHelper.columnDriverDateOfBirth}, d.${DatabaseHelper.columnDriverNationality},
             c.${DatabaseHelper.columnCircuitId}, c.${DatabaseHelper.columnCircuitName}, 
             c.${DatabaseHelper.columnCircuitLocality}, c.${DatabaseHelper.columnCircuitCountry},
             co.${DatabaseHelper.columnConstructorId}, co.${DatabaseHelper.columnConstructorName}, 
             co.${DatabaseHelper.columnConstructorNationality}
      FROM ${DatabaseHelper.racesTable} r
      INNER JOIN ${DatabaseHelper.driversTable} d 
        ON r.${DatabaseHelper.columnWinnerId} = d.${DatabaseHelper.columnDriverId}
      INNER JOIN ${DatabaseHelper.circuitsTable} c 
        ON r.${DatabaseHelper.columnCircuitId} = c.${DatabaseHelper.columnCircuitId}
      INNER JOIN ${DatabaseHelper.constructorsTable} co 
        ON r.${DatabaseHelper.columnWinningConstructorId} = co.${DatabaseHelper.columnConstructorId}
      WHERE r.${DatabaseHelper.columnSeasonYear} = ?
      ORDER BY r.${DatabaseHelper.columnId}
    ''',
      [year],
    );

    return raceMaps.map((map) {
      return _raceMapper.map(map);
    }).toList();
  }

  @override
  Future<void> cacheSeasonsWithChampions(
    List<Season> seasons, {
    int? from,
    int? to,
  }) async {
    final database = await _db.database;
    await database.transaction((txn) async {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final Set<String> processedDrivers = {};
      for (final season in seasons) {
        final driver = season.champion;
        if (!processedDrivers.contains(driver.driverId)) {
          await txn.insert(
            DatabaseHelper.driversTable,
            {
              DatabaseHelper.columnDriverId: driver.driverId,
              DatabaseHelper.columnDriverCode: driver.code,
              DatabaseHelper.columnDriverGivenName: driver.givenName,
              DatabaseHelper.columnDriverFamilyName: driver.familyName,
              DatabaseHelper.columnDriverDateOfBirth: driver.dateOfBirth,
              DatabaseHelper.columnDriverNationality: driver.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      for (final season in seasons) {
        await txn.insert(
          DatabaseHelper.seasonsTable,
          {
            DatabaseHelper.columnYear: season.year,
            DatabaseHelper.columnChampionId: season.champion.driverId,
            DatabaseHelper.columnTimestamp: timestamp,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<void> cacheSeasonRaces(int year, List<Race> races) async {
    final database = await _db.database;
    await database.transaction((txn) async {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final Set<String> processedDrivers = {};
      for (final race in races) {
        final driver = race.winner;
        if (!processedDrivers.contains(driver.driverId)) {
          await txn.insert(
            DatabaseHelper.driversTable,
            {
              DatabaseHelper.columnDriverId: driver.driverId,
              DatabaseHelper.columnDriverCode: driver.code,
              DatabaseHelper.columnDriverGivenName: driver.givenName,
              DatabaseHelper.columnDriverFamilyName: driver.familyName,
              DatabaseHelper.columnDriverDateOfBirth: driver.dateOfBirth,
              DatabaseHelper.columnDriverNationality: driver.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      final Set<String> processedCircuits = {};
      for (final race in races) {
        final circuit = race.circuit;
        if (!processedCircuits.contains(circuit.circuitId)) {
          await txn.insert(
            DatabaseHelper.circuitsTable,
            {
              DatabaseHelper.columnCircuitId: circuit.circuitId,
              DatabaseHelper.columnCircuitName: circuit.circuitName,
              DatabaseHelper.columnCircuitLocality: circuit.locality,
              DatabaseHelper.columnCircuitCountry: circuit.country,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedCircuits.add(circuit.circuitId);
        }
      }

      final Set<String> processedConstructors = {};
      for (final race in races) {
        final constructor = race.constructor;
        if (!processedConstructors.contains(constructor.constructorId)) {
          await txn.insert(
            DatabaseHelper.constructorsTable,
            {
              DatabaseHelper.columnConstructorId: constructor.constructorId,
              DatabaseHelper.columnConstructorName: constructor.name,
              DatabaseHelper.columnConstructorNationality:
                  constructor.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedConstructors.add(constructor.constructorId);
        }
      }

      await txn.delete(
        DatabaseHelper.racesTable,
        where: '${DatabaseHelper.columnSeasonYear} = ?',
        whereArgs: [year],
      );

      for (final race in races) {
        await txn.insert(DatabaseHelper.racesTable, {
          DatabaseHelper.columnSeasonYear: year,
          DatabaseHelper.columnRound: race.round,
          DatabaseHelper.columnRaceName: race.name,
          DatabaseHelper.columnDate: race.date,
          DatabaseHelper.columnWinnerId: race.winner.driverId,
          DatabaseHelper.columnCircuitId: race.circuit.circuitId,
          DatabaseHelper.columnWinningConstructorId:
              race.constructor.constructorId,
          DatabaseHelper.columnTimestamp: timestamp,
        });
      }
    });
  }

  @override
  Future<void> clearCache() async {
    await _db.clearAllTables();
  }
}
