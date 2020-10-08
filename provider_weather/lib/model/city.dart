import 'package:provider_weather/model/weather.dart';

class City {
  final String name;
  final int woeId;
  final Weather weather;

  City({
    this.name,
    this.woeId,
    this.weather,
  });

  factory City.fromJson(Map<String, dynamic> map) {
    final weathers = map['weathers'];
    return City(
      name: map['title'],
      woeId: map['woeid'],
      weather: weathers != null
          ? (weathers as List).map((e) => Weather.fromJson(e)).toList().first
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "title": name,
        "woeid": woeId,
        "weather": weather.toJson(),
      };

  City fromWeather(Weather weather) {
    return City(
      name: name,
      woeId: woeId,
      weather: weather,
    );
  }

  @override
  String toString() {
    return 'City{name: $name, woeId: $woeId, weather: $weather}';
  }
}
