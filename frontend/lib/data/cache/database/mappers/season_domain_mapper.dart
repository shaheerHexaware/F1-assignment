import 'package:f1_app/data/cache/database/database_helper.dart';
import 'package:f1_app/data/cache/database/mappers/driver_domain_mapper.dart';
import 'package:f1_app/domain/models/driver/driver.dart';
import 'package:f1_app/domain/models/season/season.dart';
import 'package:f1_app/helpers/mapper/mapper.dart';

class SeasonDomainMapper extends Mapper<Map<String, dynamic>, Season, void> {
  final DriverDomainMapper _driverMapper;

  SeasonDomainMapper(this._driverMapper);

  @override
  Season map(Map<String, dynamic> param, {void metadata}) {
    Driver driver = _driverMapper.map(param);
    return Season(year: param[DatabaseHelper.columnYear], champion: driver);
  }
}
