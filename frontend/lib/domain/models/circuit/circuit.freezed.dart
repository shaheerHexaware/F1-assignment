// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'circuit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Circuit _$CircuitFromJson(Map<String, dynamic> json) {
  return _Circuit.fromJson(json);
}

/// @nodoc
mixin _$Circuit {
  String get circuitId => throw _privateConstructorUsedError;
  String get circuitName => throw _privateConstructorUsedError;
  String get locality => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  /// Serializes this Circuit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CircuitCopyWith<Circuit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CircuitCopyWith<$Res> {
  factory $CircuitCopyWith(Circuit value, $Res Function(Circuit) then) =
      _$CircuitCopyWithImpl<$Res, Circuit>;
  @useResult
  $Res call({
    String circuitId,
    String circuitName,
    String locality,
    String country,
  });
}

/// @nodoc
class _$CircuitCopyWithImpl<$Res, $Val extends Circuit>
    implements $CircuitCopyWith<$Res> {
  _$CircuitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? circuitId = null,
    Object? circuitName = null,
    Object? locality = null,
    Object? country = null,
  }) {
    return _then(
      _value.copyWith(
            circuitId: null == circuitId
                ? _value.circuitId
                : circuitId // ignore: cast_nullable_to_non_nullable
                      as String,
            circuitName: null == circuitName
                ? _value.circuitName
                : circuitName // ignore: cast_nullable_to_non_nullable
                      as String,
            locality: null == locality
                ? _value.locality
                : locality // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CircuitImplCopyWith<$Res> implements $CircuitCopyWith<$Res> {
  factory _$$CircuitImplCopyWith(
    _$CircuitImpl value,
    $Res Function(_$CircuitImpl) then,
  ) = __$$CircuitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String circuitId,
    String circuitName,
    String locality,
    String country,
  });
}

/// @nodoc
class __$$CircuitImplCopyWithImpl<$Res>
    extends _$CircuitCopyWithImpl<$Res, _$CircuitImpl>
    implements _$$CircuitImplCopyWith<$Res> {
  __$$CircuitImplCopyWithImpl(
    _$CircuitImpl _value,
    $Res Function(_$CircuitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? circuitId = null,
    Object? circuitName = null,
    Object? locality = null,
    Object? country = null,
  }) {
    return _then(
      _$CircuitImpl(
        circuitId: null == circuitId
            ? _value.circuitId
            : circuitId // ignore: cast_nullable_to_non_nullable
                  as String,
        circuitName: null == circuitName
            ? _value.circuitName
            : circuitName // ignore: cast_nullable_to_non_nullable
                  as String,
        locality: null == locality
            ? _value.locality
            : locality // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CircuitImpl implements _Circuit {
  const _$CircuitImpl({
    required this.circuitId,
    required this.circuitName,
    required this.locality,
    required this.country,
  });

  factory _$CircuitImpl.fromJson(Map<String, dynamic> json) =>
      _$$CircuitImplFromJson(json);

  @override
  final String circuitId;
  @override
  final String circuitName;
  @override
  final String locality;
  @override
  final String country;

  @override
  String toString() {
    return 'Circuit(circuitId: $circuitId, circuitName: $circuitName, locality: $locality, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CircuitImpl &&
            (identical(other.circuitId, circuitId) ||
                other.circuitId == circuitId) &&
            (identical(other.circuitName, circuitName) ||
                other.circuitName == circuitName) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, circuitId, circuitName, locality, country);

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      __$$CircuitImplCopyWithImpl<_$CircuitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CircuitImplToJson(this);
  }
}

abstract class _Circuit implements Circuit {
  const factory _Circuit({
    required final String circuitId,
    required final String circuitName,
    required final String locality,
    required final String country,
  }) = _$CircuitImpl;

  factory _Circuit.fromJson(Map<String, dynamic> json) = _$CircuitImpl.fromJson;

  @override
  String get circuitId;
  @override
  String get circuitName;
  @override
  String get locality;
  @override
  String get country;

  /// Create a copy of Circuit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
