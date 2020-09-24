import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/data/service/api_service.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

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
}
