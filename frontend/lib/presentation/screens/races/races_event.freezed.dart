// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'races_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RacesEvent {
  int get season => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int season) loadRaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int season)? loadRaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int season)? loadRaces,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRaces value) loadRaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRaces value)? loadRaces,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRaces value)? loadRaces,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of RacesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RacesEventCopyWith<RacesEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RacesEventCopyWith<$Res> {
  factory $RacesEventCopyWith(
    RacesEvent value,
    $Res Function(RacesEvent) then,
  ) = _$RacesEventCopyWithImpl<$Res, RacesEvent>;
  @useResult
  $Res call({int season});
}

/// @nodoc
class _$RacesEventCopyWithImpl<$Res, $Val extends RacesEvent>
    implements $RacesEventCopyWith<$Res> {
  _$RacesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RacesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? season = null}) {
    return _then(
      _value.copyWith(
            season: null == season
                ? _value.season
                : season // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoadRacesImplCopyWith<$Res>
    implements $RacesEventCopyWith<$Res> {
  factory _$$LoadRacesImplCopyWith(
    _$LoadRacesImpl value,
    $Res Function(_$LoadRacesImpl) then,
  ) = __$$LoadRacesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int season});
}

/// @nodoc
class __$$LoadRacesImplCopyWithImpl<$Res>
    extends _$RacesEventCopyWithImpl<$Res, _$LoadRacesImpl>
    implements _$$LoadRacesImplCopyWith<$Res> {
  __$$LoadRacesImplCopyWithImpl(
    _$LoadRacesImpl _value,
    $Res Function(_$LoadRacesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RacesEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? season = null}) {
    return _then(
      _$LoadRacesImpl(
        null == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadRacesImpl implements _LoadRaces {
  const _$LoadRacesImpl(this.season);

  @override
  final int season;

  @override
  String toString() {
    return 'RacesEvent.loadRaces(season: $season)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRacesImpl &&
            (identical(other.season, season) || other.season == season));
  }

  @override
  int get hashCode => Object.hash(runtimeType, season);

  /// Create a copy of RacesEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRacesImplCopyWith<_$LoadRacesImpl> get copyWith =>
      __$$LoadRacesImplCopyWithImpl<_$LoadRacesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int season) loadRaces,
  }) {
    return loadRaces(season);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int season)? loadRaces,
  }) {
    return loadRaces?.call(season);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int season)? loadRaces,
    required TResult orElse(),
  }) {
    if (loadRaces != null) {
      return loadRaces(season);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadRaces value) loadRaces,
  }) {
    return loadRaces(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadRaces value)? loadRaces,
  }) {
    return loadRaces?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadRaces value)? loadRaces,
    required TResult orElse(),
  }) {
    if (loadRaces != null) {
      return loadRaces(this);
    }
    return orElse();
  }
}

abstract class _LoadRaces implements RacesEvent {
  const factory _LoadRaces(final int season) = _$LoadRacesImpl;

  @override
  int get season;

  /// Create a copy of RacesEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadRacesImplCopyWith<_$LoadRacesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
