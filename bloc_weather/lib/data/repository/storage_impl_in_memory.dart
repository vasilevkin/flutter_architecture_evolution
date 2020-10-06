import 'dart:async';

import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/data/service/api_service.dart';
import 'package:bloc_weather/model/city.dart';
import 'package:bloc_weather/model/weather.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StorageInMemoryImpl implements StorageRepository {
  final ApiService api;

  StreamController<List<City>> _citiesDataController = StreamController();
  List<City> _citiesData;
  Map<String, Image> _abbrImages = Map();
  City _selectedCity;

  // Output streams
  Stream<List<City>> get getCities => _citiesDataController.stream;

  StorageInMemoryImpl({@required this.api}) : assert(api != null) {
    _updateCities();
  }

  @override
  void dispose() {
    _citiesDataController.close();
  }

  // StorageRepository implementation

  @override
  Future<void> addCity(String cityName) async {
    City city = await _fetchCityWeatherByName(cityName);

    _citiesData.add(city);

    _updateCities();
  }

  @override
  Future<void> updateCity(City city) async {
    City cityWithWeather = await _fetchCityWeatherByName(city.name);
    var index = _citiesData.indexOf(_selectedCity);
    _citiesData[index] = cityWithWeather;

    _updateCities();
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
      image = api.getImage(abbr);
      _abbrImages[abbr] = image;
    }
    return image;
  }

  @override
  Future<List<City>> searchCitiesByQuery(String text) {
    return api.getCities(text);
  }

  @override
  City getSelectedCity() {
    return _selectedCity ?? City();
  }

  @override
  void setSelectedCity(City city) {
    _selectedCity = city ?? City();
  }

  // _private methods

  void _updateCities() async {
    if (_citiesData == null) await _addSomeCitiesInEmptyRepo();

    _citiesDataController.sink.add(_citiesData);
  }

  Future<City> _fetchCityWeatherByName(String name) async {
    City cityWithoutWeather = await api.getCity(name);
    Weather weather = await api.getWeather(cityWithoutWeather);
    City city = City(
      name: cityWithoutWeather.name,
      woeId: cityWithoutWeather.woeId,
      weather: weather,
    );

    return city;
  }

  Future<void> _addSomeCitiesInEmptyRepo() async {
    final cityNames = [
      "Moscow",
      "New York",
      "London",
      "Sydney",
      "Paris",
    ];

    _citiesData = List();

    for (String cityName in cityNames) {
      City city = await _fetchCityWeatherByName(cityName);

      _citiesData.add(city);
    }
  }
}
