import 'package:freezed_annotation/freezed_annotation.dart';

part 'circuit.freezed.dart';

@freezed
class Circuit with _$Circuit {
  const factory Circuit({
    required String circuitId,
    required String circuitName,
    required CircuitLocation location,
  }) = _Circuit;
}

@freezed
class CircuitLocation with _$CircuitLocation {
  const factory CircuitLocation({
    required String locality,
    required String country,
  }) = _CircuitLocation;
}
