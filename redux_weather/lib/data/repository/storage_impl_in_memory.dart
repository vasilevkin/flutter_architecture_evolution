import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redux_weather/data/repository/storage_repo.dart';
import 'package:redux_weather/data/service/api_service.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/data_models/weather.dart';

class StorageInMemoryImpl implements StorageRepository {
  final ApiService api;

  List<City> _citiesData;
  Map<String, Image> _abbrImages = Map();
  City _selectedCity;

  StorageInMemoryImpl({@required this.api}) : assert(api != null) {
    _updateCities();
  }

  // StorageRepository implementation

  @override
  Future<List<City>> getCities() async {
    await _updateCities();
    return _citiesData;
  }

  @override
  Future<void> addCity(String cityName) async {
    City city = await _fetchCityWeatherByName(cityName);
    city = await _fetchAndAddImageToCity(city);

    _citiesData.add(city);
    _updateCities();
  }

  @override
  Future<void> updateCity(City city) async {
    City cityWithWeather = await _fetchCityWeatherByName(city.name);
    cityWithWeather = await _fetchAndAddImageToCity(city);
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
    return _selectedCity ?? City.initial();
  }

  @override
  void setSelectedCity(City city) {
    _selectedCity = city ?? City.initial();
  }

  // _private methods

  Future<void> _updateCities() async {
    if (_citiesData == null) {
      await _addSomeCitiesInEmptyRepo();
    }
  }

  Future<City> _fetchCityWeatherByName(String name) async {
    City cityWithoutWeather = await api.getCity(name);
    Weather weather = await api.getWeather(cityWithoutWeather);
    City city = City.initial().copyWith(
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

    List<City> _citiesData2 = List();

    await Future.forEach(cityNames, (cityName) async {
      City city = await _fetchCityWeatherByName(cityName);
      city = await _fetchAndAddImageToCity(city);
      _citiesData2.add(city);
    }).then((_) {
      _citiesData = _citiesData2;
    });
  }

  Future<City> _fetchAndAddImageToCity(City city) async {
    final Image imageWeather =
        getImageForStateAbbr(city.weather.weatherStateAbbr);
    final City cityWithImage = city.copyWith(imageWeather: imageWeather);

    print('repo:: _fetchAndAddImageToCity cityWithImage= ${cityWithImage.name}, image= ${cityWithImage.imageWeather.image}');

    return cityWithImage;
  }
}
