import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/presentation/screens/races/models/race_ui.dart';
import 'package:f1_api_client/api.dart';

class Dummies {
  static const String dummyBaseUrl = "https://races.com/f1/api";

  static const dummyDriverId = "max_verstappen";
  static const dummyDriverCode = "VER";
  static const dummyDriverGivenName = "Max";
  static const dummyDriverFamilyName = "Verstappen";
  static const dummyDate = "1997-09-30";
  static const dummyNationality = "Dutch";

  static const dummyCircuitId = "bahrain";
  static const dummyCircuitName = "Bahrain International Circuit";
  static const dummyCircuitLocality = "Sakhir";
  static const dummyCircuitCountry = "Bahrain";

  static const dummyConstructorId = "red_bull";
  static const dummyConstructorName = "Red Bull Racing";
  static const dummyConstructorNationality = "Austrian";

  static const dummySeason = 2023;
  static const dummyRound = 1;
  static const dummyRaceName = "Bahrain Grand Prix";

  static Circuit createCircuit({String circuitId = dummyCircuitId}) {
    return Circuit(
      circuitId: circuitId,
      circuitName: dummyCircuitName,
      locality: dummyCircuitLocality,
      country: dummyCircuitCountry,
    );
  }

  static Season createSeason({int year = dummySeason, Driver? champion}) {
    return Season(
      year: year,
      champion: champion ?? createDriver(driverId: dummyDriverId),
    );
  }

  static Constructor createConstructor({
    String constructorId = dummyConstructorId,
  }) {
    return Constructor(
      constructorId: constructorId,
      name: dummyConstructorName,
      nationality: dummyConstructorNationality,
    );
  }

  static Driver createDriver({
    String driverId = dummyDriverId,
    String? code = dummyDriverCode,
  }) {
    return Driver(
      driverId: driverId,
      code: code,
      givenName: dummyDriverGivenName,
      familyName: dummyDriverFamilyName,
      dateOfBirth: dummyDate,
      nationality: dummyNationality,
    );
  }

  static Race createRace({
    int seasonYear = dummySeason,
    int round = dummyRound,
    String raceName = dummyRaceName,
    Circuit? circuit,
    Driver? driver,
    Constructor? constructor,
  }) {
    return Race(
      year: seasonYear,
      round: round,
      name: raceName,
      date: dummyDate,
      circuit: circuit ?? createCircuit(),
      winner: driver ?? createDriver(),
      constructor: constructor ?? createConstructor(),
    );
  }

  static RaceUi createRaceUi({
    int seasonYear = dummySeason,
    int round = dummyRound,
    String raceName = dummyRaceName,
    String driverName = "$dummyDriverGivenName $dummyDriverFamilyName",
    bool isWinnerChampion = false,
    String circuitName = "$dummyCircuitName, $dummyCircuitCountry",
    String constructorName = dummyConstructorName,
  }) {
    return RaceUi(
      year: seasonYear,
      round: round,
      name: raceName,
      date: dummyDate,
      driverName: driverName,
      isWinnerChampion: isWinnerChampion,
      circuitName: circuitName,
      constructorName: constructorName,
    );
  }

  // Dummy DTOs
  static DriverDTO createDriverDTO({
    String driverId = dummyDriverId,
    String? code = dummyDriverCode,
    String givenName = dummyDriverGivenName,
    String familyName = dummyDriverFamilyName,
    String dateOfBirth = dummyDate,
    String nationality = dummyNationality,
  }) {
    return DriverDTO(
      driverId: driverId,
      code: code,
      givenName: givenName,
      familyName: familyName,
      dateOfBirth: dateOfBirth,
      nationality: nationality,
    );
  }

  static CircuitLocationDTO createLocationDTO({
    String locality = dummyCircuitLocality,
    String country = dummyCircuitCountry,
  }) {
    return CircuitLocationDTO(locality: locality, country: country);
  }

  static CircuitDTO createCircuitDTO({
    String circuitId = dummyCircuitId,
    String circuitName = dummyCircuitName,
    CircuitLocationDTO? location,
  }) {
    return CircuitDTO(
      circuitId: circuitId,
      circuitName: circuitName,
      location: location ?? createLocationDTO(),
    );
  }

  static ConstructorDTO createConstructorDTO({
    String constructorId = dummyConstructorId,
    String name = dummyConstructorName,
    String nationality = dummyConstructorNationality,
  }) {
    return ConstructorDTO(
      constructorId: constructorId,
      name: name,
      nationality: nationality,
    );
  }

  static RaceDTO createRaceDTO({
    int seasonYear = dummySeason,
    int round = dummyRound,
    String raceName = dummyRaceName,
    String date = dummyDate,
    DriverDTO? winningDriver,
    CircuitDTO? circuit,
    ConstructorDTO? winningConstructor,
  }) {
    return RaceDTO(
      seasonYear: seasonYear,
      round: round,
      raceName: raceName,
      date: date,
      winningDriver: winningDriver ?? createDriverDTO(),
      circuit: circuit ?? createCircuitDTO(),
      winningConstructor: winningConstructor ?? createConstructorDTO(),
    );
  }

  static SeasonDTO createSeasonDTO({
    int year = dummySeason,
    DriverDTO? champion,
  }) {
    return SeasonDTO(year: year, champion: champion ?? createDriverDTO());
  }

  static Map<String, dynamic> createCircuitEntity({
    String circuitId = dummyCircuitId,
    String circuitName = dummyCircuitName,
    String locality = dummyCircuitLocality,
    String country = dummyCircuitCountry,
  }) {
    return {
      DatabaseHelper.columnCircuitId: circuitId,
      DatabaseHelper.columnCircuitName: circuitName,
      DatabaseHelper.columnCircuitLocality: locality,
      DatabaseHelper.columnCircuitCountry: country,
    };
  }

  static Map<String, dynamic> createDriverEntity({
    String driverId = dummyDriverId,
    String? code = dummyDriverCode,
    String givenName = dummyDriverGivenName,
    String familyName = dummyDriverFamilyName,
    String dateOfBirth = dummyDate,
    String nationality = dummyNationality,
  }) {
    return {
      DatabaseHelper.columnDriverId: driverId,
      DatabaseHelper.columnDriverCode: code,
      DatabaseHelper.columnDriverGivenName: givenName,
      DatabaseHelper.columnDriverFamilyName: familyName,
      DatabaseHelper.columnDriverDateOfBirth: dateOfBirth,
      DatabaseHelper.columnDriverNationality: nationality,
    };
  }

  static Map<String, dynamic> createConstructorEntity({
    String constructorId = dummyConstructorId,
    String name = dummyConstructorName,
    String nationality = dummyConstructorNationality,
  }) {
    return {
      DatabaseHelper.columnConstructorId: constructorId,
      DatabaseHelper.columnConstructorName: name,
      DatabaseHelper.columnConstructorNationality: nationality,
    };
  }

  static Map<String, dynamic> createRaceEntity({
    int seasonYear = dummySeason,
    int round = dummyRound,
    String raceName = dummyRaceName,
    String date = dummyDate,
    Map<String, dynamic>? winningDriverEntity,
    Map<String, dynamic>? circuitEntity,
    Map<String, dynamic>? winningConstructorEntity,
  }) {
    final driver = winningDriverEntity ?? createDriverEntity();
    final circuit = circuitEntity ?? createCircuitEntity();
    final constructor = winningConstructorEntity ?? createConstructorEntity();

    return {
      DatabaseHelper.columnSeasonYear: seasonYear,
      DatabaseHelper.columnRound: round,
      DatabaseHelper.columnRaceName: raceName,
      DatabaseHelper.columnDate: date,
      DatabaseHelper.columnDriverId: driver[DatabaseHelper.columnDriverId],
      DatabaseHelper.columnDriverCode: driver[DatabaseHelper.columnDriverCode],
      DatabaseHelper.columnDriverGivenName:
          driver[DatabaseHelper.columnDriverGivenName],
      DatabaseHelper.columnDriverFamilyName:
          driver[DatabaseHelper.columnDriverFamilyName],
      DatabaseHelper.columnDriverDateOfBirth:
          driver[DatabaseHelper.columnDriverDateOfBirth],
      DatabaseHelper.columnDriverNationality:
          driver[DatabaseHelper.columnDriverNationality],
      DatabaseHelper.columnCircuitId: circuit[DatabaseHelper.columnCircuitId],
      DatabaseHelper.columnCircuitName:
          circuit[DatabaseHelper.columnCircuitName],
      DatabaseHelper.columnCircuitLocality:
          circuit[DatabaseHelper.columnCircuitLocality],
      DatabaseHelper.columnCircuitCountry:
          circuit[DatabaseHelper.columnCircuitCountry],
      DatabaseHelper.columnConstructorId:
          constructor[DatabaseHelper.columnConstructorId],
      DatabaseHelper.columnConstructorName:
          constructor[DatabaseHelper.columnConstructorName],
      DatabaseHelper.columnConstructorNationality:
          constructor[DatabaseHelper.columnConstructorNationality],
    };
  }

  static Map<String, dynamic> createSeasonEntity({
    int year = dummySeason,
    Map<String, dynamic>? championEntity,
  }) {
    final driver = championEntity ?? createDriverEntity();
    return {
      DatabaseHelper.columnYear: year,
      DatabaseHelper.columnDriverId: driver[DatabaseHelper.columnDriverId],
      DatabaseHelper.columnDriverCode: driver[DatabaseHelper.columnDriverCode],
      DatabaseHelper.columnDriverGivenName:
          driver[DatabaseHelper.columnDriverGivenName],
      DatabaseHelper.columnDriverFamilyName:
          driver[DatabaseHelper.columnDriverFamilyName],
      DatabaseHelper.columnDriverDateOfBirth:
          driver[DatabaseHelper.columnDriverDateOfBirth],
      DatabaseHelper.columnDriverNationality:
          driver[DatabaseHelper.columnDriverNationality],
    };
  }
}
