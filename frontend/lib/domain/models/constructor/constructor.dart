import 'package:freezed_annotation/freezed_annotation.dart';

part 'constructor.freezed.dart';

@freezed
class Constructor with _$Constructor {
  const factory Constructor({
    required String constructorId,
    required String name,
    required String nationality,
  }) = _Constructor;
}
