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
             d.${DatabaseHelper.columnGivenName}, d.${DatabaseHelper.columnFamilyName}, 
             d.${DatabaseHelper.columnDateOfBirth}, d.${DatabaseHelper.columnNationality}
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
        givenName: map[DatabaseHelper.columnGivenName],
        familyName: map[DatabaseHelper.columnFamilyName],
        dateOfBirth: map[DatabaseHelper.columnDateOfBirth],
        nationality: map[DatabaseHelper.columnNationality],
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
             d.${DatabaseHelper.columnGivenName}, d.${DatabaseHelper.columnFamilyName}, 
             d.${DatabaseHelper.columnDateOfBirth}, d.${DatabaseHelper.columnNationality},
             c.${DatabaseHelper.columnCircuitId}, c.${DatabaseHelper.columnCircuitName}, 
             c.${DatabaseHelper.columnLocality}, c.${DatabaseHelper.columnCountry},
             co.${DatabaseHelper.columnConstructorId}, co.${DatabaseHelper.columnName} as constructor_name, 
             co.${DatabaseHelper.columnNationality} as constructor_nationality
      FROM ${DatabaseHelper.racesTable} r
      INNER JOIN ${DatabaseHelper.driversTable} d 
        ON r.${DatabaseHelper.columnWinnerId} = d.${DatabaseHelper.columnDriverId}
      INNER JOIN ${DatabaseHelper.circuitsTable} c 
        ON r.${DatabaseHelper.columnCircuitRefId} = c.${DatabaseHelper.columnCircuitId}
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
        givenName: map[DatabaseHelper.columnGivenName],
        familyName: map[DatabaseHelper.columnFamilyName],
        dateOfBirth: map[DatabaseHelper.columnDateOfBirth],
        nationality: map[DatabaseHelper.columnNationality],
      );

      final circuit = Circuit(
        circuitId: map[DatabaseHelper.columnCircuitId],
        circuitName: map[DatabaseHelper.columnCircuitName],
        locality: map[DatabaseHelper.columnLocality],
        country: map[DatabaseHelper.columnCountry],
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

      // Cache all unique drivers first
      final Set<String> processedDrivers = {};
      for (final season in seasons) {
        final driver = season.champion;
        if (!processedDrivers.contains(driver.driverId)) {
          await txn.insert(
            DatabaseHelper.driversTable,
            {
              DatabaseHelper.columnDriverId: driver.driverId,
              DatabaseHelper.columnDriverCode: driver.code,
              DatabaseHelper.columnGivenName: driver.givenName,
              DatabaseHelper.columnFamilyName: driver.familyName,
              DatabaseHelper.columnDateOfBirth: driver.dateOfBirth,
              DatabaseHelper.columnNationality: driver.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      // Cache seasons
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

      // Cache all unique drivers
      final Set<String> processedDrivers = {};
      for (final race in races) {
        final driver = race.winner;
        if (!processedDrivers.contains(driver.driverId)) {
          await txn.insert(
            DatabaseHelper.driversTable,
            {
              DatabaseHelper.columnDriverId: driver.driverId,
              DatabaseHelper.columnDriverCode: driver.code,
              DatabaseHelper.columnGivenName: driver.givenName,
              DatabaseHelper.columnFamilyName: driver.familyName,
              DatabaseHelper.columnDateOfBirth: driver.dateOfBirth,
              DatabaseHelper.columnNationality: driver.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedDrivers.add(driver.driverId);
        }
      }

      // Cache all unique circuits
      final Set<String> processedCircuits = {};
      for (final race in races) {
        final circuit = race.circuit;
        if (!processedCircuits.contains(circuit.circuitId)) {
          await txn.insert(
            DatabaseHelper.circuitsTable,
            {
              DatabaseHelper.columnCircuitId: circuit.circuitId,
              DatabaseHelper.columnCircuitName: circuit.circuitName,
              DatabaseHelper.columnLocality: circuit.locality,
              DatabaseHelper.columnCountry: circuit.country,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedCircuits.add(circuit.circuitId);
        }
      }

      // Cache all unique constructors
      final Set<String> processedConstructors = {};
      for (final race in races) {
        final constructor = race.constructor;
        if (!processedConstructors.contains(constructor.constructorId)) {
          await txn.insert(
            DatabaseHelper.constructorsTable,
            {
              DatabaseHelper.columnConstructorId: constructor.constructorId,
              DatabaseHelper.columnName: constructor.name,
              DatabaseHelper.columnNationality: constructor.nationality,
              DatabaseHelper.columnTimestamp: timestamp,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          processedConstructors.add(constructor.constructorId);
        }
      }

      // Delete existing races for this year
      await txn.delete(
        DatabaseHelper.racesTable,
        where: '${DatabaseHelper.columnSeasonYear} = ?',
        whereArgs: [year],
      );

      // Cache races
      for (final race in races) {
        await txn.insert(DatabaseHelper.racesTable, {
          DatabaseHelper.columnSeasonYear: year,
          DatabaseHelper.columnRound: race.round,
          DatabaseHelper.columnRaceName: race.name,
          DatabaseHelper.columnDate: race.date,
          DatabaseHelper.columnWinnerId: race.winner.driverId,
          DatabaseHelper.columnCircuitRefId: race.circuit.circuitId,
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
