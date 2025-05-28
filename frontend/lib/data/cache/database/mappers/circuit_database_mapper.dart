import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class CircuitDatabaseMapper
    extends Mapper<Circuit, Map<String, dynamic>, void> {
  @override
  Map<String, dynamic> map(Circuit param, {void metadata}) {
    return {
      DatabaseHelper.columnCircuitId: param.circuitId,
      DatabaseHelper.columnCircuitName: param.circuitName,
      DatabaseHelper.columnCircuitLocality: param.locality,
      DatabaseHelper.columnCircuitCountry: param.country,
    };
  }
}
