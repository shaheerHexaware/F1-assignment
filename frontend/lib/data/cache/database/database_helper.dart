import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "f1_cache.db";
  static const _databaseVersion = 1;

  static const String driversTable = 'drivers';
  static const String constructorsTable = 'constructors';
  static const String circuitsTable = 'circuits';
  static const String seasonsTable = 'seasons';
  static const String racesTable = 'races';

  static const String columnId = 'id';
  static const String columnTimestamp = 'timestamp';

  static const String columnDriverId = 'driver_id';
  static const String columnDriverCode = 'code';
  static const String columnGivenName = 'given_name';
  static const String columnFamilyName = 'family_name';
  static const String columnDateOfBirth = 'date_of_birth';
  static const String columnNationality = 'nationality';

  static const String columnConstructorId = 'constructor_id';
  static const String columnName = 'name';

  static const String columnCircuitId = 'circuit_id';
  static const String columnCircuitName = 'circuit_name';
  static const String columnLocality = 'locality';
  static const String columnCountry = 'country';

  static const String columnYear = 'year';
  static const String columnChampionId = 'champion_id';

  static const String columnSeasonYear = 'season_year';
  static const String columnRound = 'round';
  static const String columnRaceName = 'race_name';
  static const String columnDate = 'date';
  static const String columnWinnerId = 'winner_id';
  static const String columnCircuitRefId = 'circuit_id';
  static const String columnWinningConstructorId = 'constructor_id';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    await db.execute('''
      CREATE TABLE $driversTable (
        $columnDriverId TEXT PRIMARY KEY,
        $columnDriverCode TEXT,
        $columnGivenName TEXT NOT NULL,
        $columnFamilyName TEXT NOT NULL,
        $columnDateOfBirth TEXT NOT NULL,
        $columnNationality TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $constructorsTable (
        $columnConstructorId TEXT PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnNationality TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $circuitsTable (
        $columnCircuitId TEXT PRIMARY KEY,
        $columnCircuitName TEXT NOT NULL,
        $columnLocality TEXT NOT NULL,
        $columnCountry TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $seasonsTable (
        $columnYear INTEGER PRIMARY KEY,
        $columnChampionId TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL,
        FOREIGN KEY ($columnChampionId) REFERENCES $driversTable ($columnDriverId)
      )
    ''');

    await db.execute('''
      CREATE TABLE $racesTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnSeasonYear INTEGER NOT NULL,
        $columnRound INTEGER NOT NULL,
        $columnRaceName TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnWinnerId TEXT NOT NULL,
        $columnCircuitRefId TEXT NOT NULL,
        $columnWinningConstructorId TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL,
        FOREIGN KEY ($columnSeasonYear) REFERENCES $seasonsTable ($columnYear),
        FOREIGN KEY ($columnWinnerId) REFERENCES $driversTable ($columnDriverId),
        FOREIGN KEY ($columnCircuitRefId) REFERENCES $circuitsTable ($columnCircuitId),
        FOREIGN KEY ($columnWinningConstructorId) REFERENCES $constructorsTable ($columnConstructorId)
      )
    ''');

    await db.execute(
      'CREATE INDEX idx_seasons_year ON $seasonsTable ($columnYear)',
    );
    await db.execute(
      'CREATE INDEX idx_races_season ON $racesTable ($columnSeasonYear)',
    );
    await db.execute(
      'CREATE INDEX idx_races_winner ON $racesTable ($columnWinnerId)',
    );
    await db.execute(
      'CREATE INDEX idx_races_circuit ON $racesTable ($columnCircuitRefId)',
    );
    await db.execute(
      'CREATE INDEX idx_races_constructor ON $racesTable ($columnWinningConstructorId)',
    );
  }

  Future<void> clearAllTables() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(racesTable);
      await txn.delete(seasonsTable);
      await txn.delete(circuitsTable);
      await txn.delete(constructorsTable);
      await txn.delete(driversTable);
    });
  }
}
