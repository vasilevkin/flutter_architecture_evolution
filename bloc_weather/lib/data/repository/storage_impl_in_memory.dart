import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc_weather/data/app_state.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/data/service/api_service.dart';
import 'package:bloc_weather/model/city.dart';
import 'package:bloc_weather/model/weather.dart';

class StorageInMemoryImpl implements StorageRepository {
  final AppState appState;
  final ApiService api;

  StreamController<List<City>> _citiesDataController = StreamController();

  List<City> _citiesData;
  Map<String, Image> _abbrImages = Map();

  // Output streams
  Stream<List<City>> get getCities => _citiesDataController.stream;

  StorageInMemoryImpl({
    @required this.appState,
    @required this.api,
  })  : assert(appState != null),
        assert(api != null) {
    _updateCities();
  }

  @override
  void dispose() {
    _citiesDataController.close();
  }

  // StorageRepository implementation

  @override
  void _updateCities() async {
    appState.isLoading = true;

    if (_citiesData == null) {
      _citiesData = List();
      for (String cityName in appState.cityNames) {
        City city = await _fetchCityWeatherByName(cityName);

        _citiesData.add(city);
      }
    }

    _citiesDataController.sink.add(_citiesData);

    appState.isLoading = false;
  }

  @override
  Future<void> addCity(String cityName) async {
    City city = await _fetchCityWeatherByName(cityName);

    _citiesData.add(city);

    _updateCities();
  }

  @override
  Future<void> updateCity(City city) {
    // TODO: implement updateCity
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCity(City city) async {
    _citiesData.remove(city);

    _updateCities();
  }

  @override
  Image getImageForStateAbbr(String abbr) {
    Image image;
    if (_abbrImages.containsKey(abbr)) {
      image = _abbrImages[abbr];
    } else {
      api.getImage(abbr).then((value) {
        image = value;
        _abbrImages[abbr] = value;
      });
    }
    return image;
  }

  @override
  Future<List<City>> searchCitiesByQuery(String text) {
    return api.getCities(text);
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
