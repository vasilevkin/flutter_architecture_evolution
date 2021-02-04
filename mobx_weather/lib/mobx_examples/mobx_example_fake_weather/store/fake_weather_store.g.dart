// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_weather_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FakeWeatherStore on _FakeWeatherStore, Store {
  Computed<FakeStoreState> _$stateComputed;

  @override
  FakeStoreState get state =>
      (_$stateComputed ??= Computed<FakeStoreState>(() => super.state,
              name: '_FakeWeatherStore.state'))
          .value;

  final _$fakeWeatherAtom = Atom(name: '_FakeWeatherStore.fakeWeather');

  @override
  FakeWeather get fakeWeather {
    _$fakeWeatherAtom.reportRead();
    return super.fakeWeather;
  }

  @override
  set fakeWeather(FakeWeather value) {
    _$fakeWeatherAtom.reportWrite(value, super.fakeWeather, () {
      super.fakeWeather = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_FakeWeatherStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$_fakeWeatherFutureAtom =
      Atom(name: '_FakeWeatherStore._fakeWeatherFuture');

  @override
  ObservableFuture<FakeWeather> get _fakeWeatherFuture {
    _$_fakeWeatherFutureAtom.reportRead();
    return super._fakeWeatherFuture;
  }

  @override
  set _fakeWeatherFuture(ObservableFuture<FakeWeather> value) {
    _$_fakeWeatherFutureAtom.reportWrite(value, super._fakeWeatherFuture, () {
      super._fakeWeatherFuture = value;
    });
  }

  final _$getFakeWeatherAsyncAction =
      AsyncAction('_FakeWeatherStore.getFakeWeather');

  @override
  Future<dynamic> getFakeWeather(String cityName) {
    return _$getFakeWeatherAsyncAction
        .run(() => super.getFakeWeather(cityName));
  }

  @override
  String toString() {
    return '''
fakeWeather: ${fakeWeather},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
