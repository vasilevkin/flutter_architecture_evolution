import 'package:flutter/foundation.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/data/repository/storage_repo.dart';
import 'package:vanilla_structured_repository/data/service/api_service.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

class StorageInMemoryImpl implements StorageRepository {
  final AppState appState;
  final ApiService api;

  List<City> _citiesData;

  StorageInMemoryImpl({
    @required this.appState,
    @required this.api,
  })  : assert(appState != null),
        assert(api != null);

  // StorageRepository implementation

  @override
  Future<List<City>> getAllCities() async {
    appState.isLoading = true;

    if (_citiesData == null) {
      _citiesData = List();
      for (String cityName in appState.cityNames) {
        City city = await _fetchCityWeatherByName(cityName);

        _citiesData.add(city);
      }
    }

    appState.isLoading = false;

    return _citiesData;
  }

  @override
  Future<void> addCity(String cityName) async {
    City city = await _fetchCityWeatherByName(cityName);

    _citiesData.add(city);
  }

  @override
  Future<void> updateCity(City city) {
    // TODO: implement updateCity
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCity(City city) async {
    _citiesData.remove(city);
  }

  // _private methods

  Future<City> _fetchCityWeatherByName(String name) async {
    appState.isLoading = true;

    City cityWithoutWeather = await api.getCity(name);
    Weather weather = await api.getWeather(cityWithoutWeather);
    City city = City(
      name: cityWithoutWeather.name,
      woeId: cityWithoutWeather.woeId,
      weather: weather,
    );

    appState.isLoading = false;

    return city;
  }
}
