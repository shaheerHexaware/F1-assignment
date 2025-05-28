import 'package:f1_app/data/cache/cache_data_source.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/race_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/season_domain_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_database_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_database_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_database_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/race_database_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/season_database_mapper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCacheDataSource implements CacheDataSource {
  final DatabaseHelper _db;
  final SeasonDomainMapper _seasonDomainMapper;
  final RaceDomainMapper _raceDomainMapper;
  final DriverDatabaseMapper _driverDatabaseMapper;
  final CircuitDatabaseMapper _circuitDatabaseMapper;
  final ConstructorDatabaseMapper _constructorDatabaseMapper;
  final RaceDatabaseMapper _raceDatabaseMapper;
  final SeasonDatabaseMapper _seasonDatabaseMapper;

  factory DatabaseCacheDataSource({
    DatabaseHelper? db,
    SeasonDomainMapper? seasonDomainMapper,
    RaceDomainMapper? raceDomainMapper,
    DriverDatabaseMapper? driverDatabaseMapper,
    CircuitDatabaseMapper? circuitDatabaseMapper,
    ConstructorDatabaseMapper? constructorDatabaseMapper,
    RaceDatabaseMapper? raceDatabaseMapper,
    SeasonDatabaseMapper? seasonDatabaseMapper,
  }) {
    if (db != null &&
        seasonDomainMapper != null &&
        raceDomainMapper != null &&
        driverDatabaseMapper != null &&
        circuitDatabaseMapper != null &&
        constructorDatabaseMapper != null &&
        raceDatabaseMapper != null &&
        seasonDatabaseMapper != null) {
      return DatabaseCacheDataSource._(
        db,
        seasonDomainMapper,
        raceDomainMapper,
        driverDatabaseMapper,
        circuitDatabaseMapper,
        constructorDatabaseMapper,
        raceDatabaseMapper,
        seasonDatabaseMapper,
      );
    }

    final defaultDb = DatabaseHelper.instance;
    final driverDomainMapper = DriverDomainMapper();
    final circuitDomainMapper = CircuitDomainMapper();
    final constructorDomainMapper = ConstructorDomainMapper();
    final defaultSeasonDomainMapper = SeasonDomainMapper(driverDomainMapper);
    final defaultRaceDomainMapper = RaceDomainMapper(
      driverDomainMapper,
      circuitDomainMapper,
      constructorDomainMapper,
    );
    final defaultDriverDatabaseMapper = DriverDatabaseMapper();
    final defaultCircuitDatabaseMapper = CircuitDatabaseMapper();
    final defaultConstructorDatabaseMapper = ConstructorDatabaseMapper();
    final defaultRaceDatabaseMapper = RaceDatabaseMapper();
    final defaultSeasonDatabaseMapper = SeasonDatabaseMapper();

    return DatabaseCacheDataSource._(
      defaultDb,
      defaultSeasonDomainMapper,
      defaultRaceDomainMapper,
      defaultDriverDatabaseMapper,
      defaultCircuitDatabaseMapper,
      defaultConstructorDatabaseMapper,
      defaultRaceDatabaseMapper,
      defaultSeasonDatabaseMapper,
    );
  }

  DatabaseCacheDataSource._(
    this._db,
    this._seasonDomainMapper,
    this._raceDomainMapper,
    this._driverDatabaseMapper,
    this._circuitDatabaseMapper,
    this._constructorDatabaseMapper,
    this._raceDatabaseMapper,
    this._seasonDatabaseMapper,
  );

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
      return _seasonDomainMapper.map(map);
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
      return _raceDomainMapper.map(map);
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
          final driverMap = _driverDatabaseMapper.map(driver);
          driverMap[DatabaseHelper.columnTimestamp] = timestamp;

          await txn.insert(
            DatabaseHelper.driversTable,
            driverMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      for (final season in seasons) {
        final seasonMap = _seasonDatabaseMapper.map(season);
        seasonMap[DatabaseHelper.columnTimestamp] = timestamp;

        await txn.insert(
          DatabaseHelper.seasonsTable,
          seasonMap,
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
          final driverMap = _driverDatabaseMapper.map(driver);
          driverMap[DatabaseHelper.columnTimestamp] = timestamp;

          await txn.insert(
            DatabaseHelper.driversTable,
            driverMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      final Set<String> processedCircuits = {};
      for (final race in races) {
        final circuit = race.circuit;
        if (!processedCircuits.contains(circuit.circuitId)) {
          final circuitMap = _circuitDatabaseMapper.map(circuit);
          circuitMap[DatabaseHelper.columnTimestamp] = timestamp;

          await txn.insert(
            DatabaseHelper.circuitsTable,
            circuitMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedCircuits.add(circuit.circuitId);
        }
      }

      final Set<String> processedConstructors = {};
      for (final race in races) {
        final constructor = race.constructor;
        if (!processedConstructors.contains(constructor.constructorId)) {
          final constructorMap = _constructorDatabaseMapper.map(constructor);
          constructorMap[DatabaseHelper.columnTimestamp] = timestamp;

          await txn.insert(
            DatabaseHelper.constructorsTable,
            constructorMap,
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
        final raceMap = _raceDatabaseMapper.map(race);
        raceMap[DatabaseHelper.columnTimestamp] = timestamp;

        await txn.insert(DatabaseHelper.racesTable, raceMap);
      }
    });
  }

  @override
  Future<void> clearCache() async {
    await _db.clearAllTables();
  }
}
