import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/models/season/season.dart';

part 'seasons_state.freezed.dart';

@freezed
class SeasonsState with _$SeasonsState {
  const factory SeasonsState.loading() = _Loading;
  const factory SeasonsState.loaded(List<Season> seasons) = _Loaded;
  const factory SeasonsState.error(String message) = _Error;
}
