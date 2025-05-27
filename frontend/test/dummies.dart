import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/domain/models/season/season.dart';

const String dummyBaseUrl = "https://races.com/f1/api";

const dummyDriverId = "max_verstappen";
const dummyDriverCode = "VER";
const dummyDriverGivenName = "Max";
const dummyDriverFamilyName = "Verstappen";
const dummyDate = "1997-09-30";
const dummyNationality = "Dutch";

const dummyCircuitId = "bahrain";
const dummyCircuitName = "Bahrain International Circuit";
const dummyCircuitLocality = "Sakhir";
const dummyCircuitCountry = "Bahrain";

const dummyConstructorId = "red_bull";
const dummyConstructorName = "Red Bull Racing";
const dummyConstructorNationality = "Austrian";

const dummySeason = 2023;
const dummyRound = 1;
const dummyRaceName = "Bahrain Grand Prix";

class Dummies {
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
