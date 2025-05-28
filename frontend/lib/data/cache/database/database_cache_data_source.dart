import '../cache_data_source.dart';
import '../../../domain/models/season/season.dart';
import '../../../domain/models/race/race.dart';
import '../../../domain/models/driver/driver.dart';
import '../../../domain/models/circuit/circuit.dart';
import '../../../domain/models/constructor/constructor.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCacheDataSource implements CacheDataSource {
  final DatabaseHelper _db;

  DatabaseCacheDataSource({DatabaseHelper? db})
    : _db = db ?? DatabaseHelper.instance;

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
      final driver = Driver(
        driverId: map[DatabaseHelper.columnDriverId],
        code: map[DatabaseHelper.columnDriverCode],
        givenName: map[DatabaseHelper.columnDriverGivenName],
        familyName: map[DatabaseHelper.columnDriverFamilyName],
        dateOfBirth: map[DatabaseHelper.columnDriverDateOfBirth],
        nationality: map[DatabaseHelper.columnDriverNationality],
      );

      return Season(year: map[DatabaseHelper.columnYear], champion: driver);
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
      final driver = Driver(
        driverId: map[DatabaseHelper.columnDriverId],
        code: map[DatabaseHelper.columnDriverCode],
        givenName: map[DatabaseHelper.columnDriverGivenName],
        familyName: map[DatabaseHelper.columnDriverFamilyName],
        dateOfBirth: map[DatabaseHelper.columnDriverDateOfBirth],
        nationality: map[DatabaseHelper.columnDriverNationality],
      );

      final circuit = Circuit(
        circuitId: map[DatabaseHelper.columnCircuitId],
        circuitName: map[DatabaseHelper.columnCircuitName],
        locality: map[DatabaseHelper.columnCircuitLocality],
        country: map[DatabaseHelper.columnCircuitCountry],
      );

      final constructor = Constructor(
        constructorId: map[DatabaseHelper.columnConstructorId],
        name: map['constructor_name'],
        nationality: map['constructor_nationality'],
      );

      return Race(
        year: map[DatabaseHelper.columnSeasonYear],
        round: map[DatabaseHelper.columnRound],
        name: map[DatabaseHelper.columnRaceName],
        date: map[DatabaseHelper.columnDate],
        winner: driver,
        circuit: circuit,
        constructor: constructor,
      );
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
