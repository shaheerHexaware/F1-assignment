import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class SeasonDatabaseMapper extends Mapper<Season, Map<String, dynamic>, void> {
  @override
  Map<String, dynamic> map(Season param, {void metadata}) {
    return {
      DatabaseHelper.columnYear: param.year,
      DatabaseHelper.columnChampionId: param.champion.driverId,
    };
  }
}
