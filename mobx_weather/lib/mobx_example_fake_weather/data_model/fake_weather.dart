import 'package:flutter/material.dart';

class FakeWeather {
  final String cityName;
  final double temperatureCelsius;

  FakeWeather({
    @required this.cityName,
    @required this.temperatureCelsius,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is FakeWeather &&
        other.cityName == cityName &&
        other.temperatureCelsius == temperatureCelsius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;
}
