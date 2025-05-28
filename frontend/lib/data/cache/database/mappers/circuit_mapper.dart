import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/circuit/circuit.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class CircuitMapper extends Mapper<Map<String, dynamic>, Circuit, void> {
  @override
  Circuit map(Map<String, dynamic> param, {void metadata}) {
    return Circuit(
      circuitId: param[DatabaseHelper.columnCircuitId],
      circuitName: param[DatabaseHelper.columnCircuitName],
      locality: param[DatabaseHelper.columnCircuitLocality],
      country: param[DatabaseHelper.columnCircuitCountry],
    );
  }
}
