import 'package:flutter/material.dart';
import 'package:redux_weather/data_models/city.dart';

abstract class StorageRepository {
  Stream<List<City>> get getCities;

  void dispose();

  Future<void> addCity(String cityName);

  Future<void> updateCity(City city);

  Future<void> deleteCity(City city);

  Image getImageForStateAbbr(String abbr);

  Future<List<City>> searchCitiesByQuery(String text);

  void setSelectedCity(City city);

  City getSelectedCity();
}
