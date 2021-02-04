import 'dart:math';

import 'package:mobx_weather/mobx_examples/mobx_example_fake_weather/data_model/fake_weather.dart';

abstract class FakeWeatherRepository {
  Future<FakeWeather> fetchFakeWeather(String cityName);
}

class FakeWeatherRepositoryImpl implements FakeWeatherRepository {
  double cachedTempCelsius;

  @override
  Future<FakeWeather> fetchFakeWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 2),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkError();
        }

        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        return FakeWeather(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius,
        );
      },
    );
  }
}

class NetworkError extends Error {}
