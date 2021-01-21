import 'package:flutter/cupertino.dart';
import 'package:redux_weather/app/constants.dart';
import 'package:redux_weather/data_models/weather.dart';

class City {
  final String name;
  final int woeId;
  final Weather weather;

  City._({
    this.name,
    this.woeId,
    this.weather,
  });

  factory City.initial() => City._(
        name: Constants.initialName,
        woeId: Constants.initialId,
        weather: Weather.initial(),
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
    );
  }

  City copyWith({
    @required String name,
    @required int woeId,
    @required Weather weather,
  }) {
    return City._(
      name: name ?? this.name,
      woeId: woeId ?? this.woeId,
      weather: weather ?? this.weather,
    );
  }

  @override
  String toString() {
    return 'City{name: $name, woeId: $woeId, weather: $weather}';
  }
}
