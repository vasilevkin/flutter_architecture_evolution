import 'package:bloc_weather/model/city.dart';

class Weather {
  int id;
  String weatherStateName;
  String weatherStateAbbr;
  String windDirectionCompass;
  DateTime created;
  DateTime applicableDate;
  double minTemp;
  double maxTemp;
  double theTemp;
  double windSpeed;
  double windDirection;
  double airPressure;
  num humidity;
  double visibility;
  int predictability;

  Weather(
      {this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTemp,
      this.maxTemp,
      this.theTemp,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability});

  Weather.onlyTemp({
    this.id,
    this.theTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        weatherStateName: json["weather_state_name"],
        weatherStateAbbr: json["weather_state_abbr"],
        windDirectionCompass: json["wind_direction_compass"],
        created: DateTime.parse(json["created"]),
        applicableDate: DateTime.parse(json["applicable_date"]),
        minTemp: json["min_temp"].toDouble(),
        maxTemp: json["max_temp"].toDouble(),
        theTemp: json["the_temp"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDirection: json["wind_direction"].toDouble(),
        airPressure: json["air_pressure"],
        humidity: json["humidity"],
        visibility: json["visibility"].toDouble(),
        predictability: json["predictability"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weather_state_name": weatherStateName,
        "weather_state_abbr": weatherStateAbbr,
        "wind_direction_compass": windDirectionCompass,
        "created": created.toIso8601String(),
        "applicable_date":
            "${applicableDate.year.toString().padLeft(4, '0')}-${applicableDate.month.toString().padLeft(2, '0')}-${applicableDate.day.toString().padLeft(2, '0')}",
        "min_temp": minTemp,
        "max_temp": maxTemp,
        "the_temp": theTemp,
        "wind_speed": windSpeed,
        "wind_direction": windDirection,
        "air_pressure": airPressure,
        "humidity": humidity,
        "visibility": visibility,
        "predictability": predictability,
      };

  @override
  String toString() {
    return 'Weather{id: $id, weatherStateName: $weatherStateName, weatherStateAbbr: $weatherStateAbbr, windDirectionCompass: $windDirectionCompass, created: $created, applicableDate: $applicableDate, minTemp: $minTemp, maxTemp: $maxTemp, theTemp: $theTemp, windSpeed: $windSpeed, windDirection: $windDirection, airPressure: $airPressure, humidity: $humidity, visibility: $visibility, predictability: $predictability}';
  }
}
