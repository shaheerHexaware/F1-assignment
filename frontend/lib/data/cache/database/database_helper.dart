import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "f1_cache.db";
  static const _databaseVersion = 1;

  // Table names
  static const String driversTable = 'drivers';
  static const String constructorsTable = 'constructors';
  static const String circuitsTable = 'circuits';
  static const String seasonsTable = 'seasons';
  static const String racesTable = 'races';

  // Common columns
  static const String columnId = 'id';
  static const String columnTimestamp = 'timestamp';

  // Driver columns
  static const String columnDriverId = 'driver_id';
  static const String columnDriverCode = 'code';
  static const String columnGivenName = 'given_name';
  static const String columnFamilyName = 'family_name';
  static const String columnDateOfBirth = 'date_of_birth';
  static const String columnNationality = 'nationality';

  // Constructor columns
  static const String columnConstructorId = 'constructor_id';
  static const String columnName = 'name';

  // Circuit columns
  static const String columnCircuitId = 'circuit_id';
  static const String columnCircuitName = 'circuit_name';
  static const String columnLocality = 'locality';
  static const String columnCountry = 'country';

  // Season columns
  static const String columnYear = 'year';
  static const String columnChampionId = 'champion_id';

  // Race columns
  static const String columnSeasonYear = 'season_year';
  static const String columnRound = 'round';
  static const String columnRaceName = 'race_name';
  static const String columnDate = 'date';
  static const String columnWinnerId = 'winner_id';
  static const String columnCircuitRefId = 'circuit_id';
  static const String columnWinningConstructorId = 'constructor_id';

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Create the database tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');

    // Drivers table
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

    // Constructors table
    await db.execute('''
      CREATE TABLE $constructorsTable (
        $columnConstructorId TEXT PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnNationality TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL
      )
    ''');

    // Circuits table
    await db.execute('''
      CREATE TABLE $circuitsTable (
        $columnCircuitId TEXT PRIMARY KEY,
        $columnCircuitName TEXT NOT NULL,
        $columnLocality TEXT NOT NULL,
        $columnCountry TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL
      )
    ''');

    // Seasons table
    await db.execute('''
      CREATE TABLE $seasonsTable (
        $columnYear INTEGER PRIMARY KEY,
        $columnChampionId TEXT NOT NULL,
        $columnTimestamp INTEGER NOT NULL,
        FOREIGN KEY ($columnChampionId) REFERENCES $driversTable ($columnDriverId)
      )
    ''');

    // Races table
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

    // Create indices for faster queries
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
      // Delete in reverse order of dependencies
      await txn.delete(racesTable);
      await txn.delete(seasonsTable);
      await txn.delete(circuitsTable);
      await txn.delete(constructorsTable);
      await txn.delete(driversTable);
    });
  }
}
