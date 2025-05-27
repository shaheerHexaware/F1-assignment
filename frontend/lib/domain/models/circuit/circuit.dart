import 'package:freezed_annotation/freezed_annotation.dart';

part 'circuit.freezed.dart';
part 'circuit.g.dart';

@freezed
abstract class Circuit with _$Circuit {
  const factory Circuit({
    required String circuitId,
    required String circuitName,
    required String locality,
    required String country,
  }) = _Circuit;

  factory Circuit.fromJson(Map<String, dynamic> json) =>
      _$CircuitFromJson(json);
}
