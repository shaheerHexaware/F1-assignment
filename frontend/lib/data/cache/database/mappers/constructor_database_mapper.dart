import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class ConstructorDatabaseMapper
    extends Mapper<Constructor, Map<String, dynamic>, void> {
  @override
  Map<String, dynamic> map(Constructor param, {void metadata}) {
    return {
      DatabaseHelper.columnConstructorId: param.constructorId,
      DatabaseHelper.columnConstructorName: param.name,
      DatabaseHelper.columnConstructorNationality: param.nationality,
    };
  }
}
