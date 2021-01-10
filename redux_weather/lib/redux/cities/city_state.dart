import 'package:flutter/material.dart';
import 'package:redux_weather/data_models/city.dart';

@immutable
class CityState {
  final bool isError;
  final bool isLoading;
  final List<City> cities;

  CityState({this.isError, this.isLoading, this.cities});

  factory CityState.initial() => CityState(
        isError: false,
        isLoading: false,
        cities: const [],
      );

  CityState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<City> cities,
  }) {
    return CityState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      cities: cities ?? this.cities,
    );
  }
}
