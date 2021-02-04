import 'package:mobx/mobx.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/data_model/fake_weather.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/repository/fake_weather_repo.dart';

part 'fake_weather_store.g.dart';

class FakeWeatherStore extends _FakeWeatherStore with _$FakeWeatherStore {
  FakeWeatherStore(FakeWeatherRepository fakeWeatherRepository)
      : super(fakeWeatherRepository);
}

abstract class _FakeWeatherStore with Store {
  final FakeWeatherRepository _fakeWeatherRepository;

  _FakeWeatherStore(this._fakeWeatherRepository);

  @observable
  FakeWeather fakeWeather;

  @observable
  String errorMessage;

  @observable
  ObservableFuture<FakeWeather> _fakeWeatherFuture;

  @computed
  FakeStoreState get state {
    if (_fakeWeatherFuture == null ||
        _fakeWeatherFuture.status == FutureStatus.rejected) {
      return FakeStoreState.initial;
    }

    return _fakeWeatherFuture.status == FutureStatus.pending
        ? FakeStoreState.loading
        : FakeStoreState.loaded;
  }

  @action
  Future getFakeWeather(String cityName) async {
    try {
      errorMessage = null;

      _fakeWeatherFuture =
          ObservableFuture(_fakeWeatherRepository.fetchFakeWeather(cityName));

      fakeWeather = await _fakeWeatherFuture;
    } on NetworkError {
      errorMessage = 'Couldn\'t fetch fake weather. Is the device online?';
    }
  }
}

enum FakeStoreState { initial, loading, loaded }
