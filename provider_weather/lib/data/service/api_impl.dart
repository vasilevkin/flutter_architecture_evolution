import 'dart:convert';

import 'package:provider_weather/app/constants.dart';
import 'package:provider_weather/data/service/api_service.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/data_models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MetaWeatherApi implements ApiService {
  @override
  Future<City> getCity(String name) async {
    final cities = await getCities(name);
    return cities.first;
  }

  @override
  Future<List<City>> getCities(String name) async {
    final url = '${api}search/?query=$name';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities;
  }

  @override
  Future<Weather> getWeather(City city) async {
    final url = '$api${city.woeId}';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = data['consolidated_weather'] as List;
    final weatherList = weatherData.map((e) => Weather.fromJson(e)).toList();
    return weatherList.first;
  }

  @override
  Image getImage(String abbr) {
    return Image.network(
      '${host}static/img/weather/png/64/$abbr.png',
    );
  }
}
