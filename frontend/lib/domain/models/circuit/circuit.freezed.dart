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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Circuit {
  String get circuitId => throw _privateConstructorUsedError;
  String get circuitName => throw _privateConstructorUsedError;
  CircuitLocation get location => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CircuitCopyWith<Circuit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CircuitCopyWith<$Res> {
  factory $CircuitCopyWith(Circuit value, $Res Function(Circuit) then) =
      _$CircuitCopyWithImpl<$Res, Circuit>;
  @useResult
  $Res call({String circuitId, String circuitName, CircuitLocation location});

  $CircuitLocationCopyWith<$Res> get location;
}

/// @nodoc
class _$CircuitCopyWithImpl<$Res, $Val extends Circuit>
    implements $CircuitCopyWith<$Res> {
  _$CircuitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? circuitId = null,
    Object? circuitName = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      circuitId: null == circuitId
          ? _value.circuitId
          : circuitId // ignore: cast_nullable_to_non_nullable
              as String,
      circuitName: null == circuitName
          ? _value.circuitName
          : circuitName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as CircuitLocation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CircuitLocationCopyWith<$Res> get location {
    return $CircuitLocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CircuitImplCopyWith<$Res> implements $CircuitCopyWith<$Res> {
  factory _$$CircuitImplCopyWith(
          _$CircuitImpl value, $Res Function(_$CircuitImpl) then) =
      __$$CircuitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String circuitId, String circuitName, CircuitLocation location});

  @override
  $CircuitLocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$CircuitImplCopyWithImpl<$Res>
    extends _$CircuitCopyWithImpl<$Res, _$CircuitImpl>
    implements _$$CircuitImplCopyWith<$Res> {
  __$$CircuitImplCopyWithImpl(
      _$CircuitImpl _value, $Res Function(_$CircuitImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? circuitId = null,
    Object? circuitName = null,
    Object? location = null,
  }) {
    return _then(_$CircuitImpl(
      circuitId: null == circuitId
          ? _value.circuitId
          : circuitId // ignore: cast_nullable_to_non_nullable
              as String,
      circuitName: null == circuitName
          ? _value.circuitName
          : circuitName // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as CircuitLocation,
    ));
  }
}

/// @nodoc

class _$CircuitImpl implements _Circuit {
  const _$CircuitImpl(
      {required this.circuitId,
      required this.circuitName,
      required this.location});

  @override
  final String circuitId;
  @override
  final String circuitName;
  @override
  final CircuitLocation location;

  @override
  String toString() {
    return 'Circuit(circuitId: $circuitId, circuitName: $circuitName, location: $location)';
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
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, circuitId, circuitName, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      __$$CircuitImplCopyWithImpl<_$CircuitImpl>(this, _$identity);
}

abstract class _Circuit implements Circuit {
  const factory _Circuit(
      {required final String circuitId,
      required final String circuitName,
      required final CircuitLocation location}) = _$CircuitImpl;

  @override
  String get circuitId;
  @override
  String get circuitName;
  @override
  CircuitLocation get location;
  @override
  @JsonKey(ignore: true)
  _$$CircuitImplCopyWith<_$CircuitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CircuitLocation {
  String get locality => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CircuitLocationCopyWith<CircuitLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CircuitLocationCopyWith<$Res> {
  factory $CircuitLocationCopyWith(
          CircuitLocation value, $Res Function(CircuitLocation) then) =
      _$CircuitLocationCopyWithImpl<$Res, CircuitLocation>;
  @useResult
  $Res call({String locality, String country});
}

/// @nodoc
class _$CircuitLocationCopyWithImpl<$Res, $Val extends CircuitLocation>
    implements $CircuitLocationCopyWith<$Res> {
  _$CircuitLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locality = null,
    Object? country = null,
  }) {
    return _then(_value.copyWith(
      locality: null == locality
          ? _value.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CircuitLocationImplCopyWith<$Res>
    implements $CircuitLocationCopyWith<$Res> {
  factory _$$CircuitLocationImplCopyWith(_$CircuitLocationImpl value,
          $Res Function(_$CircuitLocationImpl) then) =
      __$$CircuitLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String locality, String country});
}

/// @nodoc
class __$$CircuitLocationImplCopyWithImpl<$Res>
    extends _$CircuitLocationCopyWithImpl<$Res, _$CircuitLocationImpl>
    implements _$$CircuitLocationImplCopyWith<$Res> {
  __$$CircuitLocationImplCopyWithImpl(
      _$CircuitLocationImpl _value, $Res Function(_$CircuitLocationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locality = null,
    Object? country = null,
  }) {
    return _then(_$CircuitLocationImpl(
      locality: null == locality
          ? _value.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CircuitLocationImpl implements _CircuitLocation {
  const _$CircuitLocationImpl({required this.locality, required this.country});

  @override
  final String locality;
  @override
  final String country;

  @override
  String toString() {
    return 'CircuitLocation(locality: $locality, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CircuitLocationImpl &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locality, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CircuitLocationImplCopyWith<_$CircuitLocationImpl> get copyWith =>
      __$$CircuitLocationImplCopyWithImpl<_$CircuitLocationImpl>(
          this, _$identity);
}

abstract class _CircuitLocation implements CircuitLocation {
  const factory _CircuitLocation(
      {required final String locality,
      required final String country}) = _$CircuitLocationImpl;

  @override
  String get locality;
  @override
  String get country;
  @override
  @JsonKey(ignore: true)
  _$$CircuitLocationImplCopyWith<_$CircuitLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
