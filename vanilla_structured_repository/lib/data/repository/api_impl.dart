import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:vanilla_structured_repository/app/constants.dart';
import 'package:vanilla_structured_repository/data/repository/api_repo.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

class MetaWeatherApi
    // implements ApiRepository
{
  static Future<City> getCity(String text) async {
    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body) as List;
    final cities = data.map((e) => City.fromJson(e)).toList();
    return cities.first;
  }

  static Future<Weather> getWeather(City city) async {
    final url = '$api${city.woeId}';
    final response = await http.get(url);
    final body = Utf8Decoder().convert(response.bodyBytes);
    final data = jsonDecode(body);
    final weatherData = data['consolidated_weather'] as List;
    final weatherList = weatherData.map((e) => Weather.fromJson(e)).toList();
    return weatherList.first;
  }
}
