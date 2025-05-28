import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/data/cache/database/mappers/circuit_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/constructor_mapper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/race/race.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class RaceMapper extends Mapper<Map<String, dynamic>, Race, void> {
  final DriverMapper _driverMapper;
  final CircuitMapper _circuitMapper;
  final ConstructorMapper _constructorMapper;

  RaceMapper(this._driverMapper, this._circuitMapper, this._constructorMapper);

  @override
  Race map(Map<String, dynamic> param, {void metadata}) {
    Driver driver = _driverMapper.map(param);
    Circuit circuit = _circuitMapper.map(param);
    Constructor constructor = _constructorMapper.map(param);

    return Race(
      year: param[DatabaseHelper.columnSeasonYear],
      round: param[DatabaseHelper.columnRound],
      name: param[DatabaseHelper.columnRaceName],
      date: param[DatabaseHelper.columnDate],
      winner: driver,
      circuit: circuit,
      constructor: constructor,
    );
  }
}
