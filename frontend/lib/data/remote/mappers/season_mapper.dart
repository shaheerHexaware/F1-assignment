import 'package:f1_api_client/api.dart';
import '../../../domain/models/season/season.dart';
import '../../../helpers/null_safety_helper.dart';
import '../../../helpers/mapper/mapper.dart';
import 'driver_mapper.dart';

class SeasonMapper extends Mapper<SeasonDTO, Season, void> {
  final DriverMapper _driverMapper;

  SeasonMapper(this._driverMapper);

  @override
  Season map(SeasonDTO param, {void metadata}) {
    final champion =
        param.champion.getNotNullParameter('Champion is missing') as DriverDTO;
    return Season(
      year: param.year.getNotNullParameter('Year is missing') as int,
      champion: _driverMapper.map(champion),
    );
  }
}
