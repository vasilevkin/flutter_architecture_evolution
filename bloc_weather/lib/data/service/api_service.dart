import 'package:flutter/material.dart';
import 'package:bloc_weather/model/city.dart';
import 'package:bloc_weather/model/weather.dart';

abstract class ApiService {
  Future<City> getCity(String text);

  Future<List<City>> getCities(String name);

  Future<Weather> getWeather(City city);

  Image getImage(String abbr);
}
