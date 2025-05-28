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

  // DTO Factory Methods
  static DriverDTO createDriverDTO({
    String? driverId,
    String? code = dummyDriverCode,
    String? givenName,
    String? familyName,
    String? dateOfBirth,
    String? nationality,
  }) {
    return DriverDTO(
      driverId: driverId ?? dummyDriverId,
      code: code,
      givenName: givenName ?? dummyDriverGivenName,
      familyName: familyName ?? dummyDriverFamilyName,
      dateOfBirth: dateOfBirth ?? dummyDate,
      nationality: nationality ?? dummyNationality,
    );
  }

  static CircuitLocationDTO createLocationDTO({
    String? locality,
    String? country,
  }) {
    return CircuitLocationDTO(
      locality: locality ?? dummyCircuitLocality,
      country: country ?? dummyCircuitCountry,
    );
  }

  static CircuitDTO createCircuitDTO({
    String? circuitId,
    String? circuitName,
    CircuitLocationDTO? location,
  }) {
    return CircuitDTO(
      circuitId: circuitId ?? dummyCircuitId,
      circuitName: circuitName ?? dummyCircuitName,
      location: location ?? createLocationDTO(),
    );
  }

  static ConstructorDTO createConstructorDTO({
    String? constructorId,
    String? name,
    String? nationality,
  }) {
    return ConstructorDTO(
      constructorId: constructorId ?? dummyConstructorId,
      name: name ?? dummyConstructorName,
      nationality: nationality ?? dummyConstructorNationality,
    );
  }

  static RaceDTO createRaceDTO({
    int? seasonYear,
    int? round,
    String? raceName,
    String? date,
    DriverDTO? winningDriver,
    CircuitDTO? circuit,
    ConstructorDTO? winningConstructor,
  }) {
    return RaceDTO(
      seasonYear: seasonYear ?? dummySeason,
      round: round ?? dummyRound,
      raceName: raceName ?? dummyRaceName,
      date: date ?? dummyDate,
      winningDriver: winningDriver ?? createDriverDTO(),
      circuit: circuit ?? createCircuitDTO(),
      winningConstructor: winningConstructor ?? createConstructorDTO(),
    );
  }

  static SeasonDTO createSeasonDTO({int? year, DriverDTO? champion}) {
    return SeasonDTO(
      year: year ?? dummySeason,
      champion: champion ?? createDriverDTO(),
    );
  }
}
