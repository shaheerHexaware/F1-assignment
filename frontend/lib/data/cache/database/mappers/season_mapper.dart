import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_mapper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class SeasonMapper extends Mapper<Map<String, dynamic>, Season, void> {
  final DriverMapper _driverMapper;

  SeasonMapper(this._driverMapper);

  @override
  Season map(Map<String, dynamic> param, {void metadata}) {
    Driver driver = _driverMapper.map(param);
    return Season(year: param[DatabaseHelper.columnYear], champion: driver);
  }
}
