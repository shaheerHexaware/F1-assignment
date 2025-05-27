import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/season/season.dart';

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

  static Driver createDriver({String driverId = dummyDriverId}) {
    return Driver(
      driverId: driverId,
      code: driverId.toUpperCase().substring(0, 3),
      givenName: dummyDriverGivenName,
      familyName: dummyDriverFamilyName,
      dateOfBirth: dummyDate,
      nationality: dummyNationality,
    );
  }
}
