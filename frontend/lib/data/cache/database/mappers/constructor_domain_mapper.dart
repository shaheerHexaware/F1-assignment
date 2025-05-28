import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/constructor/constructor.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class ConstructorDomainMapper
    extends Mapper<Map<String, dynamic>, Constructor, void> {
  @override
  Constructor map(Map<String, dynamic> param, {void metadata}) {
    return Constructor(
      constructorId: param[DatabaseHelper.columnConstructorId],
      name: param[DatabaseHelper.columnConstructorName],
      nationality: param[DatabaseHelper.columnConstructorNationality],
    );
  }
}
