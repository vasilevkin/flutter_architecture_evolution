import 'package:flutter/material.dart';
import 'package:bloc_weather/model/city.dart';

abstract class StorageRepository {
  Future<List<City>> getAllCities();

  Future<void> addCity(String cityName);

  Future<void> updateCity(City city);

  Future<void> deleteCity(City city);

  Image getImageForStateAbbr(String abbr);

  Future<List<City>> searchCitiesByQuery(String text);
}
