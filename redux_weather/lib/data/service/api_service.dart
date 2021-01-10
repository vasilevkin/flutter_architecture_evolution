import 'package:flutter/material.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/data_models/weather.dart';

abstract class ApiService {
  Future<City> getCity(String text);

  Future<List<City>> getCities(String name);

  Future<Weather> getWeather(City city);

  Image getImage(String abbr);
}
