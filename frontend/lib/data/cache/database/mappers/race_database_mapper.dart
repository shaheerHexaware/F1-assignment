import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class RaceDatabaseMapper extends Mapper<Race, Map<String, dynamic>, void> {
  @override
  Map<String, dynamic> map(Race param, {void metadata}) {
    return {
      DatabaseHelper.columnSeasonYear: param.year,
      DatabaseHelper.columnRound: param.round,
      DatabaseHelper.columnRaceName: param.name,
      DatabaseHelper.columnDate: param.date,
      DatabaseHelper.columnWinnerId: param.winner.driverId,
      DatabaseHelper.columnCircuitId: param.circuit.circuitId,
      DatabaseHelper.columnWinningConstructorId:
          param.constructor.constructorId,
    };
  }
}
