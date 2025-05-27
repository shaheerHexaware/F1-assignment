// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'constructor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Constructor _$ConstructorFromJson(Map<String, dynamic> json) {
  return _Constructor.fromJson(json);
}

/// @nodoc
mixin _$Constructor {
  String get constructorId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nationality => throw _privateConstructorUsedError;

  /// Serializes this Constructor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Constructor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConstructorCopyWith<Constructor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstructorCopyWith<$Res> {
  factory $ConstructorCopyWith(
    Constructor value,
    $Res Function(Constructor) then,
  ) = _$ConstructorCopyWithImpl<$Res, Constructor>;
  @useResult
  $Res call({String constructorId, String name, String nationality});
}

/// @nodoc
class _$ConstructorCopyWithImpl<$Res, $Val extends Constructor>
    implements $ConstructorCopyWith<$Res> {
  _$ConstructorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Constructor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? constructorId = null,
    Object? name = null,
    Object? nationality = null,
  }) {
    return _then(
      _value.copyWith(
            constructorId: null == constructorId
                ? _value.constructorId
                : constructorId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            nationality: null == nationality
                ? _value.nationality
                : nationality // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConstructorImplCopyWith<$Res>
    implements $ConstructorCopyWith<$Res> {
  factory _$$ConstructorImplCopyWith(
    _$ConstructorImpl value,
    $Res Function(_$ConstructorImpl) then,
  ) = __$$ConstructorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String constructorId, String name, String nationality});
}

/// @nodoc
class __$$ConstructorImplCopyWithImpl<$Res>
    extends _$ConstructorCopyWithImpl<$Res, _$ConstructorImpl>
    implements _$$ConstructorImplCopyWith<$Res> {
  __$$ConstructorImplCopyWithImpl(
    _$ConstructorImpl _value,
    $Res Function(_$ConstructorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Constructor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? constructorId = null,
    Object? name = null,
    Object? nationality = null,
  }) {
    return _then(
      _$ConstructorImpl(
        constructorId: null == constructorId
            ? _value.constructorId
            : constructorId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        nationality: null == nationality
            ? _value.nationality
            : nationality // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConstructorImpl implements _Constructor {
  const _$ConstructorImpl({
    required this.constructorId,
    required this.name,
    required this.nationality,
  });

  factory _$ConstructorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConstructorImplFromJson(json);

  @override
  final String constructorId;
  @override
  final String name;
  @override
  final String nationality;

  @override
  String toString() {
    return 'Constructor(constructorId: $constructorId, name: $name, nationality: $nationality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConstructorImpl &&
            (identical(other.constructorId, constructorId) ||
                other.constructorId == constructorId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, constructorId, name, nationality);

  /// Create a copy of Constructor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConstructorImplCopyWith<_$ConstructorImpl> get copyWith =>
      __$$ConstructorImplCopyWithImpl<_$ConstructorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConstructorImplToJson(this);
  }
}

abstract class _Constructor implements Constructor {
  const factory _Constructor({
    required final String constructorId,
    required final String name,
    required final String nationality,
  }) = _$ConstructorImpl;

  factory _Constructor.fromJson(Map<String, dynamic> json) =
      _$ConstructorImpl.fromJson;

  @override
  String get constructorId;
  @override
  String get name;
  @override
  String get nationality;

  /// Create a copy of Constructor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConstructorImplCopyWith<_$ConstructorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
