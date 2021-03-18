import 'package:flutter/material.dart';
import 'package:getx_weather/data_models/city.dart';

abstract class StorageRepository {
  Future<List<City>> getCities();

  Future<void> addCity(String cityName);

  Future<void> updateCity(City city);

  Future<void> deleteCity(City city);

  Image getImageForStateAbbr(String abbr);

  Future<List<City>> searchCitiesByQuery(String text);

  void setSelectedCity(City city);

  City getSelectedCity();
}
