import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/data_models/weather.dart';

class City {
  final String name;
  final int woeId;
  final Weather weather;
  final Image imageWeather;

  City._({
    this.name,
    this.woeId,
    this.weather,
    this.imageWeather,
  });

  factory City.initial() => City._(
        name: Constants.initialName,
        woeId: Constants.initialId,
        weather: Weather.initial(),
        imageWeather: Image.asset(Constants.placeholderImage),
      );

  factory City.fromJson(Map<String, dynamic> map) {
    final weathers = map['weathers'];
    return City._(
      name: map['title'],
      woeId: map['woeid'],
      weather: weathers != null
          ? (weathers as List).map((e) => Weather.fromJson(e)).toList().first
          : Weather.initial(),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": name,
        "woeid": woeId,
        "weather": weather.toJson(),
      };

  City fromWeather(Weather weather) {
    return City._(
      name: name,
      woeId: woeId,
      weather: weather,
      imageWeather: imageWeather,
    );
  }

  City copyWith({
    @required String name,
    @required int woeId,
    @required Weather weather,
    @required Image imageWeather,
  }) {
    return City._(
      name: name ?? this.name,
      woeId: woeId ?? this.woeId,
      weather: weather ?? this.weather,
      imageWeather: imageWeather ?? this.imageWeather,
    );
  }

  @override
  String toString() {
    return 'City{name: $name, woeId: $woeId, weather: $weather, imageWeather: $imageWeather}';
  }
}
