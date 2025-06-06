// Mocks generated by Mockito 5.4.6 from annotations
// in f1_app/test/lib/data/remote/remote_data_source_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:f1_api_client/api.dart' as _i2;
import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeApiClient_0 extends _i1.SmartFake implements _i2.ApiClient {
  _FakeApiClient_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeResponse_1 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [F1ControllerApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockF1ControllerApi extends _i1.Mock implements _i2.F1ControllerApi {
  MockF1ControllerApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ApiClient get apiClient =>
      (super.noSuchMethod(
            Invocation.getter(#apiClient),
            returnValue: _FakeApiClient_0(this, Invocation.getter(#apiClient)),
          )
          as _i2.ApiClient);

  @override
  _i4.Future<_i3.Response> getSeasonRacesWithHttpInfo(int? year) =>
      (super.noSuchMethod(
            Invocation.method(#getSeasonRacesWithHttpInfo, [year]),
            returnValue: _i4.Future<_i3.Response>.value(
              _FakeResponse_1(
                this,
                Invocation.method(#getSeasonRacesWithHttpInfo, [year]),
              ),
            ),
          )
          as _i4.Future<_i3.Response>);

  @override
  _i4.Future<List<_i2.RaceDTO>?> getSeasonRaces(int? year) =>
      (super.noSuchMethod(
            Invocation.method(#getSeasonRaces, [year]),
            returnValue: _i4.Future<List<_i2.RaceDTO>?>.value(),
          )
          as _i4.Future<List<_i2.RaceDTO>?>);

  @override
  _i4.Future<_i3.Response> getSeasonsWithChampionsWithHttpInfo({
    int? from,
    int? to,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getSeasonsWithChampionsWithHttpInfo, [], {
              #from: from,
              #to: to,
            }),
            returnValue: _i4.Future<_i3.Response>.value(
              _FakeResponse_1(
                this,
                Invocation.method(#getSeasonsWithChampionsWithHttpInfo, [], {
                  #from: from,
                  #to: to,
                }),
              ),
            ),
          )
          as _i4.Future<_i3.Response>);

  @override
  _i4.Future<List<_i2.SeasonDTO>?> getSeasonsWithChampions({
    int? from,
    int? to,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getSeasonsWithChampions, [], {
              #from: from,
              #to: to,
            }),
            returnValue: _i4.Future<List<_i2.SeasonDTO>?>.value(),
          )
          as _i4.Future<List<_i2.SeasonDTO>?>);
}
