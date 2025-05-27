import 'package:freezed_annotation/freezed_annotation.dart';

part 'constructor.freezed.dart';
part 'constructor.g.dart';

@freezed
class Constructor with _$Constructor {
  const factory Constructor({
    required String constructorId,
    required String name,
    required String nationality,
  }) = _Constructor;

  factory Constructor.fromJson(Map<String, dynamic> json) =>
      _$ConstructorFromJson(json);
}
