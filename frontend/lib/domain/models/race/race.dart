import 'package:freezed_annotation/freezed_annotation.dart';

import '../circuit/circuit.dart';
import '../constructor/constructor.dart';
import '../driver/driver.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
abstract class Race with _$Race {
  const factory Race({
    required String name,
    required Driver winner,
    required Circuit circuit,
    required Constructor constructor,
  }) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);
}
