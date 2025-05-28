// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Race {
  int get year => throw _privateConstructorUsedError;
  int get round => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  Driver get winner => throw _privateConstructorUsedError;
  Circuit get circuit => throw _privateConstructorUsedError;
  Constructor get constructor => throw _privateConstructorUsedError;

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RaceCopyWith<Race> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RaceCopyWith<$Res> {
  factory $RaceCopyWith(Race value, $Res Function(Race) then) =
      _$RaceCopyWithImpl<$Res, Race>;
  @useResult
  $Res call({
    int year,
    int round,
    String name,
    String date,
    Driver winner,
    Circuit circuit,
    Constructor constructor,
  });

  $DriverCopyWith<$Res> get winner;
  $CircuitCopyWith<$Res> get circuit;
  $ConstructorCopyWith<$Res> get constructor;
}

/// @nodoc
class _$RaceCopyWithImpl<$Res, $Val extends Race>
    implements $RaceCopyWith<$Res> {
  _$RaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? round = null,
    Object? name = null,
    Object? date = null,
    Object? winner = null,
    Object? circuit = null,
    Object? constructor = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            round: null == round
                ? _value.round
                : round // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            winner: null == winner
                ? _value.winner
                : winner // ignore: cast_nullable_to_non_nullable
                      as Driver,
            circuit: null == circuit
                ? _value.circuit
                : circuit // ignore: cast_nullable_to_non_nullable
                      as Circuit,
            constructor: null == constructor
                ? _value.constructor
                : constructor // ignore: cast_nullable_to_non_nullable
                      as Constructor,
          )
          as $Val,
    );
  }

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverCopyWith<$Res> get winner {
    return $DriverCopyWith<$Res>(_value.winner, (value) {
      return _then(_value.copyWith(winner: value) as $Val);
    });
  }

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CircuitCopyWith<$Res> get circuit {
    return $CircuitCopyWith<$Res>(_value.circuit, (value) {
      return _then(_value.copyWith(circuit: value) as $Val);
    });
  }

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConstructorCopyWith<$Res> get constructor {
    return $ConstructorCopyWith<$Res>(_value.constructor, (value) {
      return _then(_value.copyWith(constructor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RaceImplCopyWith<$Res> implements $RaceCopyWith<$Res> {
  factory _$$RaceImplCopyWith(
    _$RaceImpl value,
    $Res Function(_$RaceImpl) then,
  ) = __$$RaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    int round,
    String name,
    String date,
    Driver winner,
    Circuit circuit,
    Constructor constructor,
  });

  @override
  $DriverCopyWith<$Res> get winner;
  @override
  $CircuitCopyWith<$Res> get circuit;
  @override
  $ConstructorCopyWith<$Res> get constructor;
}

/// @nodoc
class __$$RaceImplCopyWithImpl<$Res>
    extends _$RaceCopyWithImpl<$Res, _$RaceImpl>
    implements _$$RaceImplCopyWith<$Res> {
  __$$RaceImplCopyWithImpl(_$RaceImpl _value, $Res Function(_$RaceImpl) _then)
    : super(_value, _then);

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? round = null,
    Object? name = null,
    Object? date = null,
    Object? winner = null,
    Object? circuit = null,
    Object? constructor = null,
  }) {
    return _then(
      _$RaceImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        round: null == round
            ? _value.round
            : round // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        winner: null == winner
            ? _value.winner
            : winner // ignore: cast_nullable_to_non_nullable
                  as Driver,
        circuit: null == circuit
            ? _value.circuit
            : circuit // ignore: cast_nullable_to_non_nullable
                  as Circuit,
        constructor: null == constructor
            ? _value.constructor
            : constructor // ignore: cast_nullable_to_non_nullable
                  as Constructor,
      ),
    );
  }
}

/// @nodoc

class _$RaceImpl implements _Race {
  const _$RaceImpl({
    required this.year,
    required this.round,
    required this.name,
    required this.date,
    required this.winner,
    required this.circuit,
    required this.constructor,
  });

  @override
  final int year;
  @override
  final int round;
  @override
  final String name;
  @override
  final String date;
  @override
  final Driver winner;
  @override
  final Circuit circuit;
  @override
  final Constructor constructor;

  @override
  String toString() {
    return 'Race(year: $year, round: $round, name: $name, date: $date, winner: $winner, circuit: $circuit, constructor: $constructor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RaceImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.round, round) || other.round == round) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.circuit, circuit) || other.circuit == circuit) &&
            (identical(other.constructor, constructor) ||
                other.constructor == constructor));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    year,
    round,
    name,
    date,
    winner,
    circuit,
    constructor,
  );

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RaceImplCopyWith<_$RaceImpl> get copyWith =>
      __$$RaceImplCopyWithImpl<_$RaceImpl>(this, _$identity);
}

abstract class _Race implements Race {
  const factory _Race({
    required final int year,
    required final int round,
    required final String name,
    required final String date,
    required final Driver winner,
    required final Circuit circuit,
    required final Constructor constructor,
  }) = _$RaceImpl;

  @override
  int get year;
  @override
  int get round;
  @override
  String get name;
  @override
  String get date;
  @override
  Driver get winner;
  @override
  Circuit get circuit;
  @override
  Constructor get constructor;

  /// Create a copy of Race
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RaceImplCopyWith<_$RaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
